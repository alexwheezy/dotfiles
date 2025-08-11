setl nocindent
setl expandtab
setl sw=4
setl sts=4
setl tabstop=4
setl cinkeys-=:

iabbrev <buffer> stv std::string_view

" === Simple Container Declarations ===
iabbrev <buffer> vecint std::vector<int> vec;
iabbrev <buffer> vecstr std::vector<std::string> vec;
iabbrev <buffer> veca std::vector<auto> vec;
iabbrev <buffer> mapint std::map<int, int> mp;
iabbrev <buffer> mapstr std::map<std::string, int> mp;

" === Simple Statements ===
iabbrev <buffer> cinn std::cin >> variable;<Esc>?variable<cr>ciw
iabbrev <buffer> prf printf("format\\n", args);<Esc>?format<cr>ciw
iabbrev <buffer> dbg std::cout << "DEBUG: " << variable << std::endl;<Esc>?variable<cr>ciw


" === Simple Lambdas ===
iabbrev <buffer> lambm auto mapper = [](const auto& x) { return transformation; };<Esc>?transformation<cr>ciw
iabbrev <buffer> lambf auto filter = [](const auto& x) { return condition; };<Esc>?condition<cr>ciw iabbrev <buffer> lambr auto reducer = [](const auto& acc, const auto& x) { return result; };<Esc>?result<cr>ciw
