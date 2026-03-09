// Copied from template:
// https://github.com/habedi/template-zig-project/tree/65eaff844f6b3a1afbee6c6fc32e71492c73fcf5

const std = @import("std");

const project_name = "template";

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addLibrary(.{
        .name = project_name,
        .linkage = .static,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/root.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const exe = b.addExecutable(.{
        .name = project_name,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(exe);

    const run_artifact = b.addRunArtifact(exe);
    if (b.args) |args| run_artifact.addArgs(args);
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_artifact.step);

    const test_step = b.step("test", "Run unit tests");

    {
        const lib_tests = b.addTest(.{
            .root_module = b.createModule(.{
                .root_source_file = b.path("src/root.zig"),
                .target = target,
                .optimize = optimize,
                .imports = &.{.{ .name = project_name, .module = lib.root_module }},
            }),
        });
        const lib_run = b.addRunArtifact(lib_tests);
        test_step.dependOn(&lib_run.step);
        const lib_install = b.addInstallArtifact(lib_tests, .{ .dest_sub_path = "test-root" });
        test_step.dependOn(&lib_install.step);
    }

    const doc_step = b.step("doc", "Generate documentation");
    const doc_cmd = b.addSystemCommand(&[_][]const u8{
        "zig", "doc", "--output-dir", "doc", "src/root.zig",
    });
    doc_step.dependOn(&doc_cmd.step);
}
