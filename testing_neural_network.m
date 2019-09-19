clear, clc, close all
interval_x = [-10 10];
interval_y = [-10 10];
x = linspace(interval_x(1), interval_x(2), 100);
y = linspace(interval_y(1), interval_y(2), 100);
[meshx, meshy] = meshgrid(x, y);

X = [meshx(:), meshy(:)]';


net = Network;
num_of_layers = 1;
num_of_neu_each_lay = 4 * ones(1,num_of_layers + 1);
input_vec_size = 2;

net = net.init_(num_of_layers, num_of_neu_each_lay, input_vec_size); % !!!
net = net.forward_propagation(X);

plot_output = reshape(net.outputs{end}, [100, 100]);

f = figure;
ax = axes(f); hold on; grid on; box on;
colormap('gray')
ax.XLim = interval_x;
ax.YLim = interval_y;
hSurface = surface(ax, x, y, plot_output);
contour(ax, x, y, plot_output);
