# Gym Bro

A lightweight app to track training and strength gains/progress

## Details

### To add
- inheritance between Sets and the other exercise sets models

#### RUBBER DUCK!
working on the workout page, I need both models NewWorkout and LoadedWorkout to function, aka similar classes
Both the NewWorkout and LoadedWorkout's exercises parameter look very similar:
- movement name
- movement id
- workout id
- exercise order
- number working sets
- worked muscle groups
- exercise sets

The problem is that in the initial query on the home page, the exercise sets and exercise name for
the exercises in a workout are not fetched, so they need to be fetched later. 
This means that moving from the home page to workout page we're missing these params for LoadedWorkouts
but not for NewWorkouts.

Because of this, I'll introduce a intermediate workout state: 
- LoadingWorkoutState
Which uses the exercise model
- SelectedWorkoutIntermittentExerciseModel

This will be used while the exercise name and exercise sets are queried.
Once both are grabbed, the complete LoadedWorkoutState will be emitted.

Potentially, we'll need to capture LoadingWorkoutState on the workout page, to display the exercise
boxes, but without any click functionality...


#### other
I need to make workout page function, the problem is that there is no exercises field on
on the WorkoutOnState state class, I cant add one unless its a parent class of all other exercise classes...


