vsim -voptargs=+acc=npr work.top
vcd file dump.vcd
vcd add -r sim:/*
run 1000ns
coverage report -detail