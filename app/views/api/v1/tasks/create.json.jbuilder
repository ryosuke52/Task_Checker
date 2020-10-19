json.id @task.id
json.title @task.title
json.task_info @task.task_info
json.finished @task.finished
json.limit @task.limit&.to_s