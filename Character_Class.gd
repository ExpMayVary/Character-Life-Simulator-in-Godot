class_name Character_Class extends Node


# Declare member variables for character's name and needs (max, decay, current state)

# Character's name
var Name_of_character

# Maximum values for each need
var sleep_max
var food_max
var entertainment_max
var social_max
var health_max
var physical_max
var mental_max

# Decay rates for each need
var sleep_decay
var food_decay
var entertainment_decay
var social_decay
var health_decay
var physical_decay
var mental_decay

# Current state of each need
var sleep
var food
var entertainment
var social
var health
var physical
var mental

# Initialize member variables via constructor
func _init(config = {}):
	# Initialization from the configuration dictionary
	Name_of_character = config["character_name"] 
	sleep_max = config["sleep_initial_max"] 
	food_max = config["food_initial_max"] 
	entertainment_max = config["entertainment_initial_max"] 
	social_max = config["social_initial_max"] 
	health_max = config["health_initial_max"] 
	physical_max = config["physical_initial_max"] 
	mental_max = config["mental_initial_max"] 
	sleep_decay = config["sleep_initial_decay"] 
	food_decay = config["food_initial_decay"] 
	entertainment_decay = config["entertainment_initial_decay"]
	social_decay = config["social_initial_decay"]
	health_decay = config["health_initial_decay"]
	physical_decay = config["physical_initial_decay"]
	mental_decay = config["mental_initial_decay"]

 
	sleep = round(sleep_max / 2) 
	food = round(food_max / 2)
	entertainment = round(entertainment_max / 2)
	social = round(social_max / 2)
	health = round(health_max / 2)
	physical = round(physical_max / 2)
	mental = round(mental_max / 2)

# Function to decay the needs over time
func decay_needs():
	sleep -= sleep_decay
	food -= food_decay
	entertainment -= entertainment_decay
	social -= social_decay
	health -= health_decay
	physical -= physical_decay
	mental -= mental_decay

# Function to update a specific need
func update_need(need_name, amount):
	match need_name:
		"sleep":
			sleep = clamp(sleep + amount, 0, sleep_max)
		"food":
			food = clamp(food + amount, 0, food_max)
		"entertainment":
			entertainment = clamp(entertainment + amount, 0, entertainment_max)
		"social":
			social = clamp(social + amount, 0, social_max)
		"health":
			health = clamp(health + amount, 0, health_max)
		"physical":
			physical = clamp(physical + amount, 0, physical_max)
		"mental":
			mental = clamp(mental + amount, 0, mental_max)

# Predefined list of activities and their impact on needs
# Can remove this once all activies are properly implimented in the get_activies section. 
var list_of_activities = {
	"sleeping": {"sleep": 30, "health": 5, "mental": 2},
	"eating_at_home": {"food": 20, "health": 3},
	"eating_out": {"food": 20, "social": 5, "entertainment": 2},
	"grocery_shopping": {"food": 10, "physical": 3},
	"going_to_the_gym": {"physical": 15, "health": 5},
	"socializing_at_cafe": {"social": 20, "food": 5},
	"watching_movie": {"entertainment": 15, "mental": -1},
	"reading": {"mental": 10, "entertainment": 5},
	"working_overtime": {"mental": -10, "physical": -5, "food": -5},
	"going_to_doctor": {"health": 20},
	"playing_sports": {"physical": 20, "social": 5, "health": 5},
	"taking_a_bath": {"health": 10, "mental": 5},
	"cooking": {"food": 15, "mental": 5},
	"going_to_a_concert": {"entertainment": 20, "social": 10},
	"visiting_family": {"social": 20, "mental": 5},
	"doing_yoga": {"health": 10, "mental": 10},
	"online_shopping": {"entertainment": 10, "mental": -2},
	"playing_video_games": {"entertainment": 20, "mental": -5},
	"going_to_a_museum": {"entertainment": 10, "mental": 10},
	"gardening": {"mental": 5, "physical": 5},
	"taking_a_walk": {"health": 5, "mental": 5, "physical": 5},
	"going_to_the_beach": {"entertainment": 10, "health": 5},
	"visiting_a_spa": {"health": 20, "mental": 10},
	"going_fishing": {"entertainment": 5, "mental": 5},
	"painting": {"mental": 10, "entertainment": 5},
	"writing": {"mental": 5},
	"going_to_a_party": {"social": 25, "entertainment": 35},
	"volunteering": {"social": 10, "mental": 10},
	"going_to_a_library": {"mental": 15},
	"cleaning_the_house": {"health": 5, "mental": -5}
}
# Function to get available activities based on time and character-specific 
func get_activities(time, character_name):
	var available_activities = {}
	# Activites available all the time and to everyone.  
	var base_activities = {
		"take_a_nap": {"sleep": 10},
		"eating_at_home": {"food": 20, "health": 3},
		"eating_out": {"food": 20, "social": 5, "entertainment": 2},
		"grocery_shopping": {"food": 10, "physical": 3},
		"going_to_the_gym": {"physical": 15, "health": 5},
		"socializing_at_cafe": {"social": 20, "food": 5},
		"watching_movie": {"entertainment": 15, "mental": -1},
		"reading": {"mental": 10, "entertainment": 5},
		"working_overtime": {"mental": -10, "physical": -5, "food": -5},
		"going_to_doctor": {"health": 20},
		"playing_sports": {"physical": 20, "social": 5, "health": 5},
		"taking_a_bath": {"health": 10, "mental": 5},
		"cooking": {"food": 15, "mental": 5},
		"going_to_a_concert": {"entertainment": 20, "social": 10},
		"visiting_family": {"social": 20, "mental": 5},
		"doing_yoga": {"health": 10, "mental": 10},
		"online_shopping": {"entertainment": 10, "mental": -2},
		"playing_video_games": {"entertainment": 20, "mental": -5},
		"going_to_a_museum": {"entertainment": 10, "mental": 10},
		"gardening": {"mental": 5, "physical": 5},
		"taking_a_walk": {"health": 5, "mental": 5, "physical": 5},
		"going_to_the_beach": {"entertainment": 10, "health": 5},
		"visiting_a_spa": {"health": 20, "mental": 10},
		"going_fishing": {"entertainment": 5, "mental": 5},
		"painting": {"mental": 10, "entertainment": 5},
		"writing": {"mental": 5},
		"going_to_a_party": {"social": 25, "entertainment": 35},
		"volunteering": {"social": 10, "mental": 10},
		"going_to_a_library": {"mental": 15},
		"cleaning_the_house": {"health": 5, "mental": -5}
	}
	
	# Time-based activities #WIP CERTAIN ACTIVITES ARE ONLY AVAILABLE AT CERTAIN TIMES 
	match time:
		0: # 12am - 4am
			available_activities.merge({"sleeping": {"sleep": 30, "health": 5, "mental": 2},})
		1: # 4am - 8 am
			available_activities.merge({"sleeping": {"sleep": 30, "health": 5, "mental": 2},})
		2: # 8am - 12 pm
			available_activities.merge({"sleeping": {"sleep": 30, "health": 5, "mental": 2},})
		3: # 12pm - 4 pm
			available_activities.merge({"sleeping": {"sleep": 30, "health": 5, "mental": 2},})
		4: # 4pm - 8pm
			available_activities.merge({"sleeping": {"sleep": 30, "health": 5, "mental": 2},})
		5: # 8pm - 12am
			available_activities.merge({"sleeping": {"sleep": 30, "health": 5, "mental": 2},})
	# Character-specific activities #WIP CERTAIN ACTIVITES ARE ONLY AVAILABLE FOR CERTAIN PEOPLE/s
	# Good for jobs people with special hobbys
	match character_name:
		"Jane":
			available_activities.merge({"sleeping": {"sleep": 30, "health": 5, "mental": 2},})
	
	# Merge with base activities
	available_activities.merge(base_activities)
	return available_activities
	
# Function to calculate the utility of an activity
func calculate_utility(activity):
	var total_utility = 0.0

	for need in activity.keys():
		var impact = activity[need]
		var current_value = get(need)
		var max_value = get(need + "_max")

		var base_utility = impact * float((max_value - current_value)) / float(max_value)
		var wasted_utility = max(0, current_value + impact - max_value)

		var composite_utility = base_utility - wasted_utility
		total_utility += composite_utility

	return total_utility

# Function to apply the selected activity to the characte
func apply_activity(activity_name):
	var selected_activity = list_of_activities[activity_name]
	for need in selected_activity.keys():
		var impact = selected_activity[need]
		update_need(need, impact)

# Function to select the best activity based on the calculated utility
func select_best_activity():
	# Currently setting the time to zero, later you will impliment this with what ever time system you want to add. 
	# the get_activies time section is hourly based but can easily be changed to whatever you want. though it is poorly writen so if you
	# want min by min time you will need to write alot of match statements. like one for each min in the day. 
	var activities = get_activities(0, Name_of_character)
	var best_activity = ""
	var highest_utility = -1.0
	
	for activity_name in activities.keys():
		print(activity_name)
		var activity = activities[activity_name]
		var utility = calculate_utility(activity)
		print(utility)
		if utility > highest_utility:
			best_activity = activity_name
			highest_utility = utility
	return best_activity
