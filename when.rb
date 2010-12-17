class When
    attr_accessor :precondition
    attr_accessor :precondition_result
    @parameters_must_be_chained = false
    attr_accessor :parameters

    def self.success(&block)
        instance = When.new
        instance.precondition = block
        return instance
    end

    def then_call(type_of_chain=nil,&block)
        if type_of_chain_is_not_specified?(type_of_chain)
            @block_to_call = block
            return self
        else
            @block_to_call = block
            as_a_chain
        end
    end

    def as_a_chain
        if precondition_is_executed_successfuly
            @block_to_call.call @precondition_result
        end
    end

    def with_args(arguments)
        if precondition_is_executed_successfuly
            @block_to_call.call arguments
        end
    end


    def precondition_is_executed_successfuly
        begin
            @precondition_result = @precondition.call
            return true
        rescue Exception
            return false
        end
    end

    def type_of_chain_is_not_specified?(type)
        type==nil
    end
                
end

