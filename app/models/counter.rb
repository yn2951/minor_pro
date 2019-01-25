class Counter < ApplicationRecord
  belongs_to :topic

  def self.totalize_reset
    counters = Counter.all
    counters.each do |counter|
      new_totalize_result = counter.good_totalize
      counter.update(totalize_result: new_totalize_result)
    end
    Counter.update_all(good_totalize: 0)
  end
end
