# Adding new languages to the site

Localized strings are in the `config/locales` folder. Those in English are in `en.yml`. If you would like to add another language, create another .yml file whose name is the 2 letter country code (e.g. `es.yml` for Spanish). Then copy all the mappings from the English file into the new language file and replace the values with the appropriate translations. Make sure the top level key contains the right language code (e.g. `es` instead of `en`).

From there, in `config/routes.rb`, on the line that says
```
scope "(:locale)", locale: /en/ do
```
Add the new language code in the section enclosed by forward slashes separated by a vertical pipe character. For example, to add Spanish, that line would be changed to
```
scope "(:locale)", locale: /en|es/ do
```

Then, in `app/views/shared/_navbar.html.erb`, in the section containing the locale switcher (CTRL+F for `:locale`), add an element for the new language (if only one other language, it should be a single link; otherwise, you will likely want a multi-select element).
