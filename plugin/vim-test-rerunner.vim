let g:test_runners = []

function! DefineTestRunner(test_string, run_string)
  let g:test_runners = g:test_runners + [[a:test_string, a:run_string]]
endfunction

function! RunTestFile(filename)
  let filename = a:filename
  for runner in g:test_runners
    let vs = "if " . runner[0] . "\nexecute runner[1]\nreturn 1\nendif"
    execute vs
  endfor
endfunction

function! IsTestFile(filename)
  let filename = a:filename
  for runner in g:test_runners
    let vs = "if " . runner[0] . "\nreturn 1\nendif"
    execute vs
  endfor
endfunction

function! RerunLastTest()
  if exists("g:last_test_file")
    call RunTestFile(g:last_test_file)
  else
    echo "Error: No previous test file."
  endif
endfunction

function! RunTestFileOrRerunLast()
  let file = expand('%:')
  if IsTestFile(file)
    let g:last_test_file=file
  endif
  call RerunLastTest()
endfunction


command! RunTestFileOrRerunLast  call RunTestFileOrRerunLast()
