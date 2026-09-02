// A make shebang and the conventional filename resolve to the same parser.

describe("Makefile grammar selection", () => {
  beforeEach(async () => {
    await lumine.packages.activatePackage("language-make");
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
});
