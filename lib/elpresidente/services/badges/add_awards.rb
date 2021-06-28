module Badges
  class AddAwards < ServiceWithWorksheet
    use FetchBoard, as: :fetch_board
    # https://pl.wikipedia.org/wiki/Stopnie_wojskowe_w_Polsce
    RANGES = ['mięso armatnie', 'szeregowy', 'starszy szeregowy', 'kapral', 'starszy kapral', 'plutonowy', 'sierżant', 'starszy sierżant', 'młodszy chorąży', 'chorąży', 'starszy chorąży', 'starszy chorąży sztabowy', 'podporucznik', 'porucznik', 'kapitan', 'major', 'podpułkownik', 'pułkownik', 'generał brygady', 'generał dywizji', 'generał broni', 'generał']
    
    def initialize(awards)
      @awards = awards
    end

    def call
      current_board = fetch_board

      awards.each do |user_id, options|
        current_board[user_id] = options unless current_board.key?(user_id)
        points = current_board[user_id][:points]&.to_i || 0
        points += options[:points]
        current_board[user_id][:points] = points
      end
      
      current_board.values.each_with_index do |options, index|
        row = index + 2
        worksheet[row, 1] = options[:user_id]
        worksheet[row, 2] = options[:name]
        worksheet[row, 3] = options[:points]
        worksheet[row, 4] = points_to_range(options[:points])
      end

      worksheet.save

      current_board
    end

    private

    attr_reader :awards
    
    def points_to_range(points)
      RANGES[(points.to_i / 5).floor] || RANGES[-1]
    end
  end
end