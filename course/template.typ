// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(title: none, author: none, course: "", date: none, body) = {
  let title = course + " " + title
  // Set the document's basic properties.
  set document(author: author, title: title)
  set text(lang: "sv", size: 12pt)

  set page(header-ascent: 40%, header: {
    set text(size: 12pt)
    box(
      width: 100%,
      grid(
        columns: (1fr, 1fr, 1fr),
        grid.cell(
          align: top + left,
          [
            #strong(author)
          ],
        ),
        grid.cell(
          align: top + center,
          [
            #course
          ],
        ),
        grid.cell(
          align: top + right,
          [
            #strong(date)
          ],
        ),
      ),
    )
  })

  set page(numbering: "1")

  // set page(
  //   numbering: "1",
  //   number-align: center,
  //   header: authors.map(author => strong(author)).fold("", (a, b) => a + b)
  //     + h(1fr)
  //     + date,
  // )
  // set heading(numbering: "1.1")

  align(left, stack(
    dir: ttb,
    spacing: 0.8em,
    text(2em, weight: 700, title),
  ))

  // Main body.
  set par(justify: true)

  show sym.lt.eq: sym.lt.eq.slant
  show sym.gt.eq: sym.gt.eq.slant
  show sym.emptyset: sym.diameter

  set math.mat(delim: ("[", "]"))

  // show sym.forall: math.class.with("binary")
  // show sym.forall: math.class.with("binary")

  show enum: it => {
    show math.equation.where(block: true): set align(left)
    it
  }

  body
}

#let hrule = line(length: 100%)

#let long-division(quotient: [], divisor: [], ..pairs) = context {
  let left-margin = measure($-($).width

  let pairs = pairs.pos()

  let pairs = pairs.map(pair => {
    if pair.len() >= 2 {
      pair.at(1) = h(-left-margin) + $-(#pair.at(1))$
    }
    pair
  })

  table(
    columns: 2,
    stroke: none,
    table.cell(
      colspan: 2,
      quotient,
    ),
    table.hline(),
    table.vline(x: 1, end: 2),
    table.cell(x: 1, divisor),
    table.hline(y: 2, start: 1, end: 2),
    ..(
      pairs
        .enumerate()
        .map(((index, pair)) => {
          let cells = pair.map(
            element => table.cell(x: 0, element),
          )

          (
            table.hline(start: 0, end: 1, y: 2 * index + 1),
            ..cells,
          )
        })
        .flatten()
    ),
  )
}

#let left-math(content) = {
  show math.equation.where(block: true): set align(left)
  show math.equation.where(block: true): set pad(left: 1em)
  content
}

#let note(note-text, body, sep: ":") = {
  show math.equation.where(block: true): set align(left)
  show math.equation.where(block: true): set pad(left: 1em)
  box(grid(
    columns: 2,
    gutter: 3pt,
    align(top, strong(note-text + sep)), align(top, body),
  ))
}

#let soft-heading(heading, body) = {
  par(
    strong(heading) + [: ] + body,
    hanging-indent: 1.5em,
  )
}

#let labelled(label, body) = {
  box[
    #label:
    #pad(left: 1em, body)
  ]
}

#let def = note.with("Def")
#let obs = note.with("Obs")
#let ex = note.with("Ex")
#let anm = note.with("Anm")
#let sats = note.with("Sats")
#let bevis = note.with("Bevis")
#let konsekvens = note.with("Konsekvens")
#let lemma = note.with("Lemma")
#let lösn(body) = {
  set enum(numbering: "a)")
  note("Lösn", body)
}
#let jmf = note.with("Jmf")
#let notera = note.with("Notera")
#let faktum = note.with("Faktum")
#let uppgift(number, body) = {
  set enum(numbering: "a)")
  note([Uppgift #number], body, sep: ".")
}

#let Sin = "Sin"
#let Cos = "Cos"
#let Tan = "Tan"

#let sgd = "sgd"
#let mgm = "mgm"
#let modop = $class("binary", "%")$

#let universe = math.cal($U$)
#let power = math.cal($P$)
#let rel = math.class("binary", math.cal($R$))
#let partition = math.cal($E$)

#let multinom(upper, ..lower) = math.binom(upper, lower.pos().join($,$))

// Stirlingtal-funktionen
#let stir = "S"

#let quad = sym.space.quad
#let em = h(1em)

#let textrel(text) = math.class("binary", "\"" + text + "\"")

#let och = math.class("binary", "och")
#let eller = math.class("binary", "eller")
#let icke = math.class("unary", "icke")
#let VL = "VL"
#let HL = "HL"

#let sant = "SANT"
#let falskt = "FALSKT"

// #let qeget = box(height: 1em, width: 1em, stroke: 0.5pt, align(center + horizon, [🐐]))
#let qeget = context {
  let qeget = stack(
    dir: ttb,
    align(center + top, [🐐]),
    align(center + top, $qed$),
  )
  let qeget_size = measure(qeget)
  let qed_size = measure($qed$)

  box(
    height: 1em,
    align(
      bottom,
      box(
        width: qed_size.width,
        height: qeget_size.height,
        qeget,
      ),
    ),
  )
}

#let mod(value) = $space ("mod" value)$

#let vecvar(var) = math.accent(var, sym.arrow.r)
#let conj(var) = math.overline(var)
#let len(var) = {
  math.lr($||var||$)
}
#let proj = math.op("proj")
#let tal = "tal"
#let span = "span"
#let line(points) = math.accent(points, sym.arrow.r)
#let trans(content) = $content^"T"$
#let omm = "omm"
#let col = math.op("col")
#let rank = math.op("rank")
#let bas(var) = math.cal(var)
#let stdbas = bas([E])

#let dx = $dif x$
#let dy = $dif y$
#let dz = $dif z$
#let dt = $dif t$

#let eval(content) = math.lr(sym.space.thin + content + sym.space.thin + [\|])
#let eval(content) = math.lr([\[] + pad(x: 0em, y: 0.4em, math.equation(content)) + [\]])
// #let eval(content) = math.lr([\[] + content + [\]])
// #let eval(content) = $[#(pad(x:0em,y:0.4em, content))]$

#let encircle(content) = context {
  let transform(dimension) = dimension - 0.0em
  // let ratio = 0.4;

  let size = measure(content)
  let circle = circle(
    [
      #set align(center + horizon)
      #box(
        width: transform(size.width),
        height: transform(size.height),
        // stroke: 1pt,
      )
    ],
    inset: 0pt,
    outset: 1pt,
  )
  let circle-size = measure(circle)

  place(
    dx: -circle-size.width / 2 + size.width / 2,
    dy: -circle-size.height / 2,
    circle,
  )

  content
}

#let math-list(content) = {
  show math.equation.where(block: false): math.equation.with(block: true)
  show math.equation: align.with(start)
  // TODO: Horrible magic value...
  show math.equation: box.with(baseline: 35%)

  set enum(number-align: end + horizon, tight: false)
  set list(tight: false, marker: {
    ([•], [‣], [–]).map(align.with(horizon))
  })

  content
}

#let inline-math(content) = {
  show math.equation.where(block: true): box.with(baseline: 35%)

  content
}

#let shrug = "¯\\_(ツ)_/¯"

#let inf = sym.infinity
#let comp = sym.complement

#let lhopital = "L'Hôpital"
#let lhopitals = "L'Hôpitals"

#let bdry = "bdry"

#let difp = sym.partial
#let Dif = $upright(D)$
#let grad = "grad"

#let auto-grid-left(auto-sized, grow-sized, gutter: 1em) = left-math(grid(
  columns: (auto, 1fr),
  gutter: gutter,
  auto-sized, grow-sized,
))

#let auto-grid-right(grow-sized, auto-sized, gutter: 1em) = left-math(grid(
  columns: (1fr, auto),
  gutter: gutter,
  grow-sized, auto-sized,
))

#let detmat(content) = math.mat(delim: "|", content)

#let diam = "diam"

#let integral2 = sym.integral.double
#let integral3 = sym.integral.triple

#let color-yellow = color.rgb("#FFD43B")
#let yellow(content) = text(fill: color-yellow, content)
#let color-red = color.rgb("#FF8787")
#let red(content) = text(fill: color-red, content)
#let color-blue = color.rgb("#4DABF7")
#let blue(content) = text(fill: color-blue, content)
