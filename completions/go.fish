function __cache_or_get_go_completion -d "Create go completions"
    mkdir -p "/tmp/go_completion_cache_for_$USER"
	set -l hashed_pwd (echo (pwd) | md5sum | cut -d " " -f 1)
	set -l go_cache_file "/tmp/go_completion_cache_for_$USER/$hashed_pwd"
	
	if not test -f "$go_cache_file"
		go -T 2>&1 | grep "^go" |cut -d " " -f 2 > "$go_cache_file"
	end
	
	cat "$go_cache_file"
end

complete -x -c go -a "(__cache_or_get_go_completion)" --description 'go Task'