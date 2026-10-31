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

  it("recognizes exact Make interpreters in extensionless executables", () => {
    for (const text of [
      "#!/usr/bin/make -f",
      "#!/usr/bin/make -f\r\n",
      "#!/usr/bin/env make -f",
      "#!/usr/bin/env -S make -f",
      "#!/usr/bin/env.exe -S make -f",
    ])
      expect(lumine.grammars.selectGrammar("executable", text).scopeName)
        .withContext(text)
        .toBe("source.makefile");
  });

  it("rejects Make names in wrapper names or other interpreter arguments", () => {
    for (const text of [
      "#!/usr/bin/not-make -f",
      "#!/usr/bin/python make -f",
      "#!/usr/bin/env -S python make -f",
      "#!/usr/bin/make-wrapper -f",
      "#!/usr/bin/make -fake",
    ])
      expect(lumine.grammars.selectGrammar("executable", text).scopeName)
        .withContext(text)
        .not.toBe("source.makefile");
  });
});
