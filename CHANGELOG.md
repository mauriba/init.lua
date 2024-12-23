# Changelog

## 1.0.0 (2024-12-23)


### ⚠ BREAKING CHANGES

* **cpp:** change namespace generation in header snippet to first subdirectory only
* add keymaps for lsp navigation on LspAttach
* Remove configs that will be language-specific instead

### Features

* &lt;leader&gt;cd changes CWD to buffer's directory ([6ae20eb](https://github.com/mauriba/init.lua/commit/6ae20ebb116c94bdf50c939e3e2c821eb0b0e4c1))
* add additional per-language plugins & cpp code generation plugin ([8fd320e](https://github.com/mauriba/init.lua/commit/8fd320e7e89a6a8734dd454d477d9425b15a7b95))
* add comment block folds and a function for ftplugin scripts to add comment styles for it ([c4c569d](https://github.com/mauriba/init.lua/commit/c4c569d7bde5d5a3083d5cb82ba8ccb77b5dc3dd))
* add conform.nvim for simple formatter management that falls back to lsp ([8ce740f](https://github.com/mauriba/init.lua/commit/8ce740f5c691204fdc4283d5b754c87a6ee599f0))
* add copilot as completion source ([7b7f28f](https://github.com/mauriba/init.lua/commit/7b7f28fd798ddfc3fd71735df8bcee14f1f98f3f))
* add copilot as completion source ([#14](https://github.com/mauriba/init.lua/issues/14)) ([a614e73](https://github.com/mauriba/init.lua/commit/a614e73b02fc41d44a2c244deaecc3b76a811b05))
* add cpp lsp and sample ([b02dd42](https://github.com/mauriba/init.lua/commit/b02dd421370b47363a0ad914e5198c021df543a2))
* add dap conifgs and dap support for cpp ([2900010](https://github.com/mauriba/init.lua/commit/290001046a4ecc4d26277f7e27d02a879914b406))
* add discord presence ([e2a29b4](https://github.com/mauriba/init.lua/commit/e2a29b4f9c105f241a1c54ea836ad42433e46c5d))
* add keymaps for lsp navigation on LspAttach ([3ab650f](https://github.com/mauriba/init.lua/commit/3ab650f64f4f4aee0766466c74834bbc334fbdee))
* add lsp config with start function for ftplugin ([497b809](https://github.com/mauriba/init.lua/commit/497b8093a54c0a0d937fcaa75c41fd61135dbed7))
* add neocmakelsp ([e0ca23e](https://github.com/mauriba/init.lua/commit/e0ca23e9cbea12e6e507931a118d758c8607eb8c))
* add notify.lua for better notifications ([f25fa7b](https://github.com/mauriba/init.lua/commit/f25fa7bbf6bacf10cf5c823aae6827e74a33a763))
* add per-language luasnips and add C++ header generation snippet ([b9dac21](https://github.com/mauriba/init.lua/commit/b9dac217cccc2980b6d3cb01699a504facd73663))
* add per-language-settings for lsps, folding, formatting, debugging ([#13](https://github.com/mauriba/init.lua/issues/13)) ([4f8a352](https://github.com/mauriba/init.lua/commit/4f8a35224844aa6c2e8e5044c8f1f1734b9fb0fb))
* add powershell support ([56c0f2c](https://github.com/mauriba/init.lua/commit/56c0f2c291b7d45e6cfc9a966fc1ee58c0f43248))
* add region fold generator that considers per-language comment styles ([440070d](https://github.com/mauriba/init.lua/commit/440070de7eedffd50c1a46400f0bea192471d011))
* add release-please for automatic releases ([9a2d118](https://github.com/mauriba/init.lua/commit/9a2d1184d9e4e9a524f926d8764ae59533855920))
* add simple terraform config and .tf/.tfvars -&gt; terraform mapping ([984169e](https://github.com/mauriba/init.lua/commit/984169e6e82d129e1d1dc6a53b332d5ac2282684))
* add syntax highlighting and default settings for cisco commands ([#15](https://github.com/mauriba/init.lua/issues/15)) ([b50c957](https://github.com/mauriba/init.lua/commit/b50c95722b43abe6b250dca47819fa504621bece))
* add vscode-like icons in autocompletion menue ([bb7c20a](https://github.com/mauriba/init.lua/commit/bb7c20aa11dd4fccf6e31251e3d800e4eac801fd))
* added auto pairs ([787e021](https://github.com/mauriba/init.lua/commit/787e021dbb0d47bb594ecdd27fe22114472b4f24))
* added basic terraform lsp support ([10c3282](https://github.com/mauriba/init.lua/commit/10c3282b8bd6c1a01fb78a565d113e702b532218))
* added basic terraform lsp support ([#8](https://github.com/mauriba/init.lua/issues/8)) ([5f756b1](https://github.com/mauriba/init.lua/commit/5f756b1ec2f5589bab424cca737c920d0c914d93))
* added color highlights for color codes ([ba60f0e](https://github.com/mauriba/init.lua/commit/ba60f0e0973045358f593b331cf0b9c87b05ba71))
* added formatter support with conform.nvim - install clang-format with Mason and add a .clang-format file somewhere in the project ancestry ([683ccb4](https://github.com/mauriba/init.lua/commit/683ccb4b0d7086a056437274c8685354bf9647d2))
* added harpoon ([aa96d02](https://github.com/mauriba/init.lua/commit/aa96d022b3a386fdc2d6c9871594cb5c4e66b7e6))
* added oil file explorer ([0582860](https://github.com/mauriba/init.lua/commit/0582860d099d275947b8104b5d4efdc843c2c2e8))
* added telescope ([23f8b3c](https://github.com/mauriba/init.lua/commit/23f8b3c3b4e9360374709685c9a380d9ed1e526a))
* added telescope history view of opened buffers ([0c3680a](https://github.com/mauriba/init.lua/commit/0c3680a30feda3311c5556fbeacaf440a80da2a5))
* added terminal ([1dc4fae](https://github.com/mauriba/init.lua/commit/1dc4faec39a13f5b186a1ca1147e968db723b75f))
* added todo-comments ([303938a](https://github.com/mauriba/init.lua/commit/303938a3c2d244f335dcffa9badf518d62f0f039))
* added trouble ([b73627d](https://github.com/mauriba/init.lua/commit/b73627d586d1ef68685ab7f6485d911bcb2652f5))
* adding fugitive and treesitter ([882abde](https://github.com/mauriba/init.lua/commit/882abde5df09a8a4805b88487ef257871e86a781))
* adding lsp renaming ([d9083d7](https://github.com/mauriba/init.lua/commit/d9083d748417c4ae75c597d1ead99e9d1b8a994f))
* Basic PowerShell support including region and comment block folds ([0e53d65](https://github.com/mauriba/init.lua/commit/0e53d65e87e7b3910b2999ced84508e554acde42))
* change tab size based on language in config/lang.lua ([b03fc28](https://github.com/mauriba/init.lua/commit/b03fc288a4d030f6f57f24ac52579757dec45351))
* configure neovim rich presence for discord ([02ea93f](https://github.com/mauriba/init.lua/commit/02ea93fea18a785001d249e1da409146906be6d4))
* configured code folding & status column for it ([cd116a8](https://github.com/mauriba/init.lua/commit/cd116a858d24a64e094dabb0162ec11809ae4096))
* configuring oil editor ([a63c431](https://github.com/mauriba/init.lua/commit/a63c43132ded81916dfb69730fab67166732c96b))
* filled readme.md ([0683dd7](https://github.com/mauriba/init.lua/commit/0683dd7342139fa3dc105bf4a0174a739db22892))
* improving harpoon and lsp navigations ([203da45](https://github.com/mauriba/init.lua/commit/203da45f3e73bf7ef204dfafad168d9b81af2adf))
* keybind for making background transparent after colorscheme change ([7bd8ea4](https://github.com/mauriba/init.lua/commit/7bd8ea4f90d1a362b9cebf4f1fc20b263ec89afb))
* more intuitive support for terminal ([393acd0](https://github.com/mauriba/init.lua/commit/393acd0c10f360988e8f9c672b37fbb151ad51e6))
* open terminal from current oil dir ([3f873b5](https://github.com/mauriba/init.lua/commit/3f873b5a25fe2d5f8739b31157b559a970df33f0))
* remaps for moving lines up and down ([d540b89](https://github.com/mauriba/init.lua/commit/d540b893544fd78b1176964a0e1b7cb8810a823f))
* some default settings - also refactore: removed lua/mauriba/ dir and added plugin group subdirectory 'plugins/colors/' ([8ac1877](https://github.com/mauriba/init.lua/commit/8ac1877dd37b35be25f01f7d984f2c8004b22b7a))
* write comment ([e6c92f6](https://github.com/mauriba/init.lua/commit/e6c92f69262d4655c4cf9b8f0031d1826f80a2c7)), closes [#12](https://github.com/mauriba/init.lua/issues/12)


### Bug Fixes

* add comment styles in ftplugin scripts ([ff69eff](https://github.com/mauriba/init.lua/commit/ff69eff2616357a5f9db5509ce05a0dc0c6f7fc1))
* add commentstring for terraform ([1d1661c](https://github.com/mauriba/init.lua/commit/1d1661c7cdeeb4af9e88554c459afe5e76a56823))
* check whether lsp server is known by lspconfig before executing .launch() ([7524539](https://github.com/mauriba/init.lua/commit/75245393aac5f3d6e58ffd635a16eee4d7d50954))
* **cpp:** change namespace generation in header snippet to first subdirectory only ([577b13e](https://github.com/mauriba/init.lua/commit/577b13ee5acab741665148021bac2648115ee38a))
* **discord:** remove test button; add repository button ([3dbf414](https://github.com/mauriba/init.lua/commit/3dbf414967ccdc53410a10dbd17ab035f8ab2ebd))
* enable snippet expansion for lua function autocomplete ([902c8cd](https://github.com/mauriba/init.lua/commit/902c8cd261f87b891eb13b6241c7640e044ab8a4))
* fix codelldb C++ debugging on windows ([bf745be](https://github.com/mauriba/init.lua/commit/bf745bed2a21975908ac79240ed6f8ebf57571e4))
* fixed :Q not quitting neovim like :q ([f9206d7](https://github.com/mauriba/init.lua/commit/f9206d7caaa5f6fc9b9a6d0d750992cbd6b03026))
* improve custom folds to work more versatile ([86d72b8](https://github.com/mauriba/init.lua/commit/86d72b88ed93dc953cd29facf8337c9937ee2925))
* improve custom folds to work more versatile ([#10](https://github.com/mauriba/init.lua/issues/10)) ([0c25a34](https://github.com/mauriba/init.lua/commit/0c25a347acc77b5ca5be1291dc4a575ed9d39f1c))
* make nvim-dap work with lldb and cpp sample ([36784b8](https://github.com/mauriba/init.lua/commit/36784b8cff67bb088f2b56221acb610745496217))
* make region folds work ([acf1717](https://github.com/mauriba/init.lua/commit/acf17179b497fbbdbada589c13401a87c16ca6a0))
* **pipeline:** add token for release-please ([e3963e1](https://github.com/mauriba/init.lua/commit/e3963e15a9c3a6e0159cb7adc86f43f67b70b206))
* **pipeline:** fix release-please type ([4251746](https://github.com/mauriba/init.lua/commit/42517463397ff03382c4bcae89a275474541a856))
* properly adding cmake lsp ([6323457](https://github.com/mauriba/init.lua/commit/6323457b26f99bec483b1243f5388d7b0efa00e0))
* **telescope:** only load native fzf when available ([029f8f5](https://github.com/mauriba/init.lua/commit/029f8f585694887cb3f54f5d14d7ab1330c713e5))
* treat nil from ufo folding as empty dictionary (allows custom folding on buffers without native folds) ([cd20d0d](https://github.com/mauriba/init.lua/commit/cd20d0db410ab08d901b313eef9338f9692d858c))
* using neocmakelsp now ([2d70dc0](https://github.com/mauriba/init.lua/commit/2d70dc0ab4aa016e5ab86a9c6b84ded1ce815f46))


### Code Refactoring

* Remove configs that will be language-specific instead ([4ca1470](https://github.com/mauriba/init.lua/commit/4ca14700911b9857c66326fe3be22530abd48ca4))
