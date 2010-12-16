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

    def then(&block)
        @block_to_call = block
        return self
    end

    def precondition_is_executed_successfuly
        begin
            @precondition_result = @precondition.call
            return true
        rescue Exception
            return false
        end
    end

    def as_a_chain
        if precondition_is_executed_successfuly
            @block_to_call.call @precondition_result
        end
    end
end

