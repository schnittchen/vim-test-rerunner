let g:vim_test_rerunner_runners = []

function! vim_test_rerunner#DefineRunner(test_string, run_string)
  let g:vim_test_rerunner_runners = [[a:test_string, a:run_string]] + g:vim_test_rerunner_runners
endfunction

"" example configuration:
" call vim_test_rerunner#DefineRunner("filename =~ '_spec.rb'", "exec '!rspec ' .  shell_filename")
