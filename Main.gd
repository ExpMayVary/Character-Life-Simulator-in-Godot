extends Control


# Declare variables for the character 'Jane' and her initial configuration
var jane
var jane_config_dict = {
	"character_name": "Jame",
	"sleep_initial_max": 100,
	"food_initial_max": 100,
	"entertainment_initial_max": 100,
	"social_initial_max": 100,
	"health_initial_max": 100,
	"physical_initial_max": 100,
	"mental_initial_max": 100,
	"sleep_initial_decay": 12,
	"food_initial_decay": 6,
	"entertainment_initial_decay": 6,
	"social_initial_decay": 3,
	"health_initial_decay": 1,
	"physical_initial_decay": 3,
	"mental_initial_decay": 1
}

# Declare GUI label variables
var sleep_label
var food_label
var entertainment_label
var social_label
var health_label
var physical_label
var mental_label
var activity_label

# Declare the timer variable
var activity_timer

# Called when the node enters the scene tree for the first time
func _ready():
	# Initialize GUI label nodes
	sleep_label = get_node("SleepLabel")
	food_label = get_node("FoodLabel")
	entertainment_label = get_node("EntertainmentLabel")
	social_label = get_node("SocialLabel")
	health_label = get_node("HealthLabel")
	physical_label = get_node("PhysicalLabel")
	mental_label = get_node("MentalLabel")
	activity_label = get_node("ActivityLabel")
	# Initialize the timer node
	activity_timer = $Timer
	
	# Create a new Character_Class instance for 'Jane' using the configuration dictionary
	jane = Character_Class.new(jane_config_dict)
	
	
func _process(_delta):
	update_gui()

func update_gui():
	# Update each label with the corresponding need's current value
	sleep_label.text = "Sleep: " + str(jane.sleep)
	food_label.text = "Food: " + str(jane.food)
	entertainment_label.text = "Entertainment: " + str(jane.entertainment)
	social_label.text = "Social: " + str(jane.social)
	health_label.text = "Health: " + str(jane.health)
	physical_label.text = "Physical: " + str(jane.physical)
	mental_label.text = "Mental: " + str(jane.mental)


func _on_timer_timeout():
	# Select the best activity for 'Jane' and apply its effects
	var best_activity = jane.select_best_activity()
	jane.apply_activity(best_activity)
	# Update the activity label with the selected activity
	activity_label.text = "Activity: " + str(best_activity)
	# Decay the needs of 'Jane'
	jane.decay_needs()
