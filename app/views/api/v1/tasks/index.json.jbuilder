json.array! @tasks do |task|
   json.id task.id
   json.title task.title
   json.finished task.finished
   json.limit task.limit&.to_s
   json.task_info task.task_info
end