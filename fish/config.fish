function fish_prompt
    eval powerline-go -error $status -jobs (count (jobs -p))
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
