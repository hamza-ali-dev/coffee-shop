json.id order.hashid
json.total order.total
json.expected_preparation_time distance_of_time_in_words(Time.current - order.expected_at)
json.status order.status.humanize