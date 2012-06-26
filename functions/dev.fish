function dev
  if test $argv
    set dir ~/dev/workspaces/$argv
    if test -d $dir
      cd $dir
    else
      echo "Cannot find any project named '$argv'"
    end
  else
    echo "Usage: dev <project>"
  end
end
