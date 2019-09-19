classdef Layer
    properties(Access = public)
        input_vector_size
        number_of_neurons
    end
    properties(Access = public)
        input
        output
    end
    properties(Access = public)
        neurons = Neuron;
    end
    
    methods(Access = public)
    
        function obj = init_(obj, number_of_neurons, input_vector_size)
            obj.number_of_neurons = number_of_neurons;
            obj.input_vector_size = input_vector_size;
            
            for i = 1:number_of_neurons
                if i == 1
                    obj.neurons = Neuron;
                else
                    obj.neurons(i) = Neuron;
                end
                obj.neurons(i) = obj.neurons(i).init_(input_vector_size);
            end
        end
        
        function obj = forward_propagation(obj, input)
            obj.input = input;
            neurons = obj.neurons;
            for i = 1:obj.number_of_neurons
                neurons(i) = obj.neurons(i).forward_propagation(input);
                obj.output(i,:) = neurons(i).output;
            end
        end
    
    end
    methods(Access = public)
        
        function obj = plotLayerLines(obj, ax, color_)
            for i = 1:obj.number_of_neurons
                obj.neurons(i).plotNeuroLine(ax, color_);
            end
        end
    end

end