profile on

N = 116;
n = 3;
s = 1:n;
exclude = N+1;
b = 1;
while b
	[s,b] = subsets(s,N,exclude);
end

profile viewer;
profile off