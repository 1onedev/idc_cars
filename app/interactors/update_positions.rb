class UpdatePositions
  include Interactor

  delegate :resource, :positions, :attribute, to: :context

  def call
    positions.map do |k, data|
      ActiveRecord::Base.connection.execute <<~SQL
        UPDATE #{resource}
        SET #{attribute} = #{data['position']}
        WHERE #{resource}.id = #{data['id'].to_i}
      SQL
    end
  end
end
