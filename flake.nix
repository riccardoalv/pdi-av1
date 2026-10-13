{
  description = "UNIR - Processamento de Imagens - AV1 (GNU Octave)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            # pacote "image": apenas para leitura, escrita, exibicao e interface (pkg load image)
            (pkgs.octave.withPackages (ps: [ ps.image ]))
            pkgs.python3
            pkgs.python3Packages.miss-hit # mh_style (formatter), mh_lint
            pkgs.gnumake
            (pkgs.texliveMedium.withPackages (ps: [
              ps.latexmk
              ps.tcolorbox
              ps.environ
              ps.tikzfill
              ps.pdfcol
              ps.listingsutf8
              ps.enumitem
            ]))
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
