classdef Network
    properties(Access = public)
        input_vector_size
        number_of_layers
        number_of_neurons_each_layers
    end
    properties(Access = public)
        inputs
        outputs
    end
    properties(Access = public)
        layers = Layer;
        last_layer = Layer;
    end
    methods(Access = public)
        function obj = init_(obj, number_of_layers, number_of_neurons_each_layers, input_vector_size)
            % checking input validity
            if number_of_layers + 1 ~= size(number_of_neurons_each_layers,2)
                disp("Do not MATCHING input size");
                return
            end
            
            obj.input_vector_size               = input_vector_size;
            obj.number_of_layers                = number_of_layers;
            obj.number_of_neurons_each_layers   = number_of_neurons_each_layers;
            
            obj.inputs  = cell(1,number_of_layers);
            obj.outputs = cell(1,number_of_layers);
            for i = 1:number_of_layers
                if i == 1
                    obj.layers = Layer;
                    input_vec = input_vector_size;
                else
                    obj.layers(i) = Layer;
                    input_vec = number_of_neurons_each_layers(i-1);
                end
                obj.layers(i) = obj.layers(i).init_(number_of_neurons_each_layers(i),input_vec);
            end
            
        obj.last_layer = Layer;
        obj.last_layer.init_(number_of_neurons_each_layers(end), input_vec)
        end
        
        function obj = forward_propagation(obj, input)
            obj.inputs{1} = input;
            for i = 1:obj.number_of_layers
                if i ~= 1
                    obj.inputs{i} = obj.outputs{i-1};
                end
                layer = obj.layers(i);
                layer = layer.forward_propagation(obj.inputs{i});
                obj.layers(i) = layer;
                obj.outputs{i} = layer.output;
            end
            layer = obj.last_layer;
            layer = layer.forward_propagation(obj.outputs{end});
            obj.last_layer = layer;
            obj.outputs{end+1} = obj.last_layer.output;
        end
    end
end