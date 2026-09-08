{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  version = "0.4.1";

  # Upstream ships statically linked musl binaries for Linux and universal-free
  # per-arch binaries for macOS. Building from source would recompile all of
  # Typst, so the release artifacts are used instead.
  targets = {
    aarch64-darwin = {
      target = "aarch64-apple-darwin";
      hash = "sha256-FXrIO32RmY58Z1/DYKO92J3oHlXyBgcsBSsURhKeqb8=";
    };
    x86_64-darwin = {
      target = "x86_64-apple-darwin";
      hash = "sha256-QIYR4XdAGcxQ+gl+RTEzUGz4uN3ifowV/iRm0eplmVQ=";
    };
    aarch64-linux = {
      target = "aarch64-unknown-linux-musl";
      hash = "sha256-XTzNe1j+DWBxffUM5Cn8OdyL4Kv8FmgXvc4bK3ciGQ4=";
    };
    x86_64-linux = {
      target = "x86_64-unknown-linux-musl";
      hash = "sha256-zyYiBrLIn010aQtcgl1f/OH2M+spAJSLUMwAbczr4yw=";
    };
  };
in

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tytanic";
  inherit version;

  src =
    let
      system = stdenvNoCC.hostPlatform.system;
      spec =
        targets.${system}
          or (throw "tytanic: no release artifact for system ${system}");
    in
    fetchurl {
      url = "https://github.com/typst-community/tytanic/releases/download/v${version}/tytanic-${spec.target}.tar.xz";
      inherit (spec) hash;
    };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -Dm755 */tt "$out/bin/tt"
    runHook postInstall
  '';

  meta = {
    description = "Test runner for Typst projects and packages";
    homepage = "https://github.com/typst-community/tytanic";
    license = [
      lib.licenses.mit
      lib.licenses.asl20
    ];
    mainProgram = "tt";
    platforms = builtins.attrNames targets;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
