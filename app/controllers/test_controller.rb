class TestController < ApplicationController
  def index

  end

  def start
    mem_start = `ps -o rss= -p #{Process.pid}`.to_i
    a = []
    1000000.times do
      a << Object.new
    end
    mem_alloc = `ps -o rss= -p #{Process.pid}`.to_i
    a = nil
    GC.start
    mem_after_gc = `ps -o rss= -p #{Process.pid}`.to_i
    render json: {mem_start: mem_start,
                  mem_allocated: mem_alloc,
                  mem_after_gc: mem_after_gc}
  end
end
