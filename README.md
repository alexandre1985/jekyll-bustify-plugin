# Jekyll Bustify Plugin

A efficient plugin to create bust cache links of assets geared towards build performance and simplicity of use

## Instalation

Copy the .rb file into your `_plugins/` project directory (if you don't have the `_plugins` directory in your jeykll website project, just created it)

## Usage

for example

```
{{ '/asset/my-beloved-asset.ext' | bustify }}

```

The hash by default is 5 characters in length (enough for my current website project needs). If you want more or less characters in the hash, for example 7 characters, use:

```
{{ '/asset/my-beloved-asset.ext' | bustify: 7 }}

```

### My hack

If you modify an asset file that is a dependency of a bustify file (such as an SASS partial file that is called by an include of another SASS file), you have to run the build command two times, in order to get the right hash



## Contribution

I you are a Jekyll plugin ninja or an Ruby master, please do help me make this plugin better

Some helpful documentation can be found in the [Jekyll Classes Documentation page](https://www.rubydoc.info/github/jekyll/jekyll/master)

Read the [CONTRIBUTING.md](./CONTRIBUTING.md) file to know the guide
