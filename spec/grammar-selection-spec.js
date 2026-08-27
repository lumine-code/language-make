// A first-line match is worth 0.5 to a grammar's score, and preferring
// Tree-sitter is worth only 0.1. So whenever a TextMate grammar declares
// `firstLineMatch` and its Tree-sitter twin declares no `firstLineRegex`, every
// file whose first line matches quietly gets the TextMate grammar — here, a
// makefile run directly through a `make -f` shebang.

describe("Makefile grammar selection", () => {
  beforeEach(async () => {
    await lumine.packages.activatePackage("language-make");
    lumine.config.set("editor.useTreeSitterParsers", true);
  });

  it("prefers the Tree-sitter grammar for a make shebang", () => {
    const grammar = lumine.grammars.selectGrammar("Makefile", "#!/usr/bin/make -f\nall:\n\techo\n");

    expect(grammar.scopeName).toBe("source.makefile");
    expect(grammar.constructor.name).toBe("TreeSitterGrammar");
  });

  it("prefers the Tree-sitter grammar for an ordinary makefile", () => {
    const grammar = lumine.grammars.selectGrammar("Makefile", "all:\n\techo\n");

    expect(grammar.scopeName).toBe("source.makefile");
    expect(grammar.constructor.name).toBe("TreeSitterGrammar");
  });

  it("still honours the TextMate preference", () => {
    lumine.config.set("editor.useTreeSitterParsers", false);

    const grammar = lumine.grammars.selectGrammar("Makefile", "#!/usr/bin/make -f\nall:\n");

    expect(grammar.scopeName).toBe("source.makefile");
    expect(grammar.constructor.name).toBe("Grammar");
  });
});
