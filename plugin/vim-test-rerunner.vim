function! RunTestFile(file)
  " TODO: needs quoting
  execute '!rspec ' . a:file
endfunction

function! IsTestFile(file)
  if a:file =~ "_spec.rb"
    return 1
  endif
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
