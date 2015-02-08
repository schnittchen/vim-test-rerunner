let s:test_runners = []

function! DefineTestRunner(test_string, run_string)
  let s:test_runners = s:test_runners + [[a:test_string, a:run_string]]
endfunction

function! IndexOfMatchingRunner(filename)
  let index = 0
  let filename = a:filename
  let shell_filename = shellescape(filename)
  for runner in s:test_runners
    let test_value = eval(runner[0])
    if test_value
      return index
    endif
    let index = index + 1
  endfor
  return -1
endfunction

function! RunTestFile(filename)
  let index = IndexOfMatchingRunner(a:filename)
  let filename = a:filename
  let shell_filename = shellescape(filename)
  execute s:test_runners[index][1]
endfunction

function! IsTestFile(filename)
  if IndexOfMatchingRunner(a:filename) == -1
    return 0
  else
    return 1
  endif
endfunction

function! RerunLastTest()
  if exists("s:last_test_file")
    call RunTestFile(s:last_test_file)
  else
    echo "Error: No previous test file."
  endif
endfunction

function! RunTestFileOrRerunLast()
  let file = expand('%:')
  if IsTestFile(file)
    let s:last_test_file=file
  endif
  call RerunLastTest()
endfunction


command! RunTestFileOrRerunLast  call RunTestFileOrRerunLast()

"" example configuration:
" call DefineTestRunner("filename =~ '_spec.rb'", "exec '!rspec ' .  shell_filename")

