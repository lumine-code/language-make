// A first-line match is worth 0.5 to a grammar's score, and preferring
// Tree-sitter is worth only 0.1. So whenever a TextMate grammar declares
// `firstLineMatch` and its Tree-sitter twin declares no `firstLineRegex`, every
// file whose first line matches quietly gets the TextMate grammar — here, a
// makefile run directly through a `make -f` shebang.

describe("Makefile grammar selection", () => {
  beforeEach(async () => {
    await atom.packages.activatePackage("language-make");
    atom.config.set("language.useTreeSitterParsers", true);
  });

  it("prefers the Tree-sitter grammar for a make shebang", () => {
    const grammar = atom.grammars.selectGrammar("Makefile", "#!/usr/bin/make -f\nall:\n\techo\n");

    expect(grammar.scopeName).toBe("source.makefile");
    expect(grammar.constructor.name).toBe("TreeSitterGrammar");
  });

  it("prefers the Tree-sitter grammar for an ordinary makefile", () => {
    const grammar = atom.grammars.selectGrammar("Makefile", "all:\n\techo\n");

    expect(grammar.scopeName).toBe("source.makefile");
    expect(grammar.constructor.name).toBe("TreeSitterGrammar");
  });

  it("still honours the TextMate preference", () => {
    atom.config.set("language.useTreeSitterParsers", false);

    const grammar = atom.grammars.selectGrammar("Makefile", "#!/usr/bin/make -f\nall:\n");

    expect(grammar.scopeName).toBe("source.makefile");
    expect(grammar.constructor.name).toBe("Grammar");
  });
});
