if status --is-login
	for p in /usr/local/mysql/bin ~/.config/fish/bin ~/homebrew/bin
		if test -d $p
			set PATH $p $PATH
		end
	end
end

# Textmate defaults to /usr/bin/mate, but let's check for /usr/local/bin/mate
if test -f "/usr/local/bin/mate"
	set -x EDITOR "/usr/local/bin/mate -w"
else
	set -x EDITOR "/usr/bin/mate -w"
end

set fish_greeting ""
set -x CLICOLOR 1

function parse_git_branch
	sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function parse_svn_revision
	sh -c 'svn info 2> /dev/null' | sed -n '/^Revision/p' | sed -e 's/^Revision: \(.*\)/\1/'
end

function fish_prompt -d "Write out the prompt"
	# Color writeable dirs green, read-only dirs red
	if test -w "."
		printf ' %s%s' (set_color green) (prompt_pwd)
	else
		printf ' %s%s' (set_color red) (prompt_pwd)
	end

	# Print subversion revision
	if test -d ".svn"
		printf ' %s%s@%s' (set_color normal) (set_color blue) (parse_svn_revision)
	end

	# Print git branch
	if test -d ".git"
		printf ' %s%s/%s' (set_color normal) (set_color blue) (parse_git_branch)
	end
	printf '%s> ' (set_color normal)
end

set BROWSER open

bind \cr "rake"

function ss -d "Run the script/server"
	script/server
end

function sc -d "Run the Rails console"
	script/console
end

set -x JAVA_HOME "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home"

# Set up go language environment.
set -x GOROOT (brew --prefix)/Cellar/go/HEAD
set -x GOARCH amd64
set -x GOOS darwin



