classdef Neuron
    properties(Access = public)
        input_vector_size
        Weight
        bais
    end
    properties(Access = public)
        input
        y
        output
    end
    properties(Access = public)
        h
    end
    methods(Access = public)
        function obj = init_(obj, input_vector_size)
            obj.input_vector_size = input_vector_size;
            obj.Weight = sqrt(9)*randn(1, input_vector_size);
            obj.bais = sqrt(9)*randn(1, 1);
        end
        function obj = sigmoid(obj)
            obj.output = 1./(1 + exp(-obj.y));
        end
        function obj = forward_propagation(obj, input)
            obj.input = input;
            
            [n, m] = size(input);
            data_size = 1;
            if (n == obj.input_vector_size) && (m ~= obj.input_vector_size)
                data_size = m;
            elseif (n ~= obj.input_vector_size) && (m == obj.input_vector_size)
                data_size = n;
            end
            cumWeight = obj.Weight;
            obj.y = cumWeight * obj.input + obj.bais.*ones(1,data_size);
            obj = sigmoid(obj);
        end
    end
    methods(Access = public)
        
        function obj = plotNeuroLine(obj, ax, color_)
            w = obj.Weight;
            b = obj.bais;
            % w*x+b = 0 --> [w1 w2]*[x1 x2]' + b = 0 --> -x2*w2 = w1*x1 + b
            % --> x2 = -w1/w2*x1 - b/w2
            xx = linspace(ax.XLim(1), ax.XLim(2), 100);
            yy = -w(1)/w(2)*xx - b/w(2);
            
            plot(ax, xx, yy,'-','color',color_);
        end
    end
    
    
end