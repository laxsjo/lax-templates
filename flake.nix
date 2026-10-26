{
  description = "My personal collection of flake templates";

  outputs = { self }: {
    templates = {
      course = {
        path = ./course;
        description = "Typst template for my KTH courses";
      };
      generic = {
        path = ./generic;
        description = "Generic template, containing an empty dev shell";
      };
      rust = {
        path = ./rust;
        description = "Rust template, using Crane";
      };
      typst = {
        path = ./typst;
        description = "Typst template";
      };
      zig = {
        path = ./zig;
        description = "Zig template, using custom build program";
      };
    };
  };
}
