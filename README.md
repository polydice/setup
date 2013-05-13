# Setup

The standard OS X setup for our laptops in Polydice. 

## Requirement

Written for Mac OS X 10.8 Mountain Lion, but should also works for 10.7 Lion.

## App Store

Head for Updates tab and download all the system updates first.

Then, install the following apps:

1. Evernote
2. Growl

## Download Software

Some apps need to be downloaded from the Internet.

1. [Mou](http://mouapp.com)
2. [Google Chrome](http://www.google.com/chrome) (Stable channel)
3. [Dropbox](https://www.dropbox.com/downloading)
4. [Skype](http://www.skype.com/go/downloading)
5. [Hipchat](https://www.hipchat.com/mac) or [Propane](http://propaneapp.com/) (for Campfire)
6. [Xcode Command Line Utility](https://developer.apple.com/downloads)

## Shell

Then you can simply run the script "setup.sh" included in this repo.

```
curl -L https://raw.github.com/polydice/setup/master/setup.sh | bash -s  
```

It'll check and install the following things:

1. Xcode Command Line Tools
2. Homebrew
3. wget
4. rbenv
5. Ruby 1.9.3-p327 (Set as default Ruby)
6. MySQL
7. ImageMagick
8. Redis
9. Config Git color for color output
10. Bundler
11. Rails
12. Pow & Powder (Writes rbenv paths to powconfig)

## Sublime Text 2

Download and install [Sublime Text 2](http://www.sublimetext.com/2).

### Packages

Then install [Sublime Package Control](http://wbond.net/sublime_packages/package_control/installation) to manage ST2 packages. Don't forget to restart Sublime Text 2 after installation.

1. [Soda Theme](https://github.com/buymeasoda/soda-theme)
2. [SublimeLinter](https://github.com/SublimeLinter/SublimeLinter)
3. [SideBarEnhancements](https://github.com/titoBouzout/SideBarEnhancements)

### Settings

Open Sublime Text 2, choose "Sublime Text 2 > Preferences > Settings - User" from menu.

Then edit the file as follows:

```
 {
	"bold_folder_labels": true,
	"color_scheme": "Packages/User/Espresso Soda.tmTheme",
	"ensure_newline_at_eof_on_save": true,
	"file_exclude_patterns":
	[
		".DS_Store",
		".gitkeep",
		"dump.rdb"
	],
	"folder_exclude_patterns":
	[
		".git",
		".sass-cache",
		"coverage",
		"log",
		"tmp"
	],
	"font_face": "Menlo",
	"font_size": 13.0,
	"highlight_modified_tabs": true,
	"save_on_focus_lost": true,
	"tab_size": 2,
	"theme": "Soda Light.sublime-theme",
	"translate_tabs_to_spaces": true,
	"trim_trailing_white_space_on_save": true
}
```

This settings was based on [Sam Soffes](http://soff.es)'s one.

### Command Line

Also, you need to setup the command line utility for it. You can run:

```
ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
```


## Customized

After the setup, you should start to customize the environment.

### SSH (Required)

Generate SSH keys and copy/paste to GitHub.

```
ssh-keygen -t rsa -C "your_email@youremail.com"
```


### Git (Required)

Configure user information for Git.

```
git config --global user.name "Your Name"
git config --global user.email you@example.com
```

### Sublime Text 2 Themes

This [GitHub repo](https://github.com/daylerees/colour-schemes) contains many beautiful color schemes made by Dayle Rees. 

You can install "Dayle Rees Colour Schemes" via Package Control.

### Propane

For better output and services integrations of Propane. We recommend gasoline gem for customizations.

```
gem i gasoline
gasoline ignite
```

## License

Copyright (c) 2012 Richard Lee & Polydice, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
