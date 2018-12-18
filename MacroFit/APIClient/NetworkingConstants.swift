//
//  NetworkingConstants.swift
//  MacroFit
//
//  Created by Chandresh Singh on 20/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

struct NetworkingConstants{
    
    static let BASE = "https://mf.simplifii.xyz/api/v1/"

    //Courses and Challenges API
    static let COURSES_AND_CHALLENGES_URL = "custom/CoursesAndChallenges"
    
    
    static let GET_COURSES_AND_CHALLENGES = BASE + COURSES_AND_CHALLENGES_URL
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    static let baseUrl = "https://mf.simplifii.xyz/api/v1/"
    static let cards = "cards"
    static let courses = "custom/courses"
    static let lessons = "custom/courseAndItsLessons"
    static let exercises = "custom/lessonAndItsExercises"
    static let users = "cards"
    static let orders = "cards"
    static let meals = "cards"
    static let login = "admin/authenticate"
    static let activityLevels = "static/activitylevels"
    static let fitnessGoals = "cards"
    static let orderPlacementDetails = "custom/order_placement_details"
    static let deliveryDate = "custom/delivery_date"
    static let payment = "payment"
    static let logout = "logout"
    static let userRecipes = "custom/user_recipes"
    static let facebookLogin = "custom/facebook_login"
    static let challenges = "cards"
    static let uploadFileToS3 = "s3/upload_file"
    static let userNetwork = "user_network_contacts"
    static let courseFeedback = "custom/feedbackOnCourse"
    static let lessonFeedback = "custom/feedbackOnLesson"
    static let lessonCompleted = "custom/markLessonCompleted"
    //
    
    static let cardsUrl = baseUrl + cards
    static let coursesUrl = baseUrl + courses
    static let lessonsUrl = baseUrl + lessons
    static let exercisesUrl = baseUrl + exercises
    static let usersUrl = baseUrl + users
    static let ordersUrl = baseUrl + orders
    static let mealsUrl = baseUrl + meals
    static let loginUrl = baseUrl + login
    static let activityLevelsUrl = baseUrl + activityLevels
    static let fitnessGoalsUrl = baseUrl + fitnessGoals
    static let orderPlacementDetailsUrl = baseUrl + orderPlacementDetails
    static let deliveryDateUrl = baseUrl + deliveryDate
    static let paymentUrl = baseUrl + payment
    static let logoutUrl = baseUrl + logout
    static let userRecipesUrl = baseUrl + userRecipes
    static let facebookLoginUrl = baseUrl + facebookLogin
    static let challengesUrl = baseUrl + challenges
    static let uploadFileToS3Url = baseUrl + uploadFileToS3
    static let userNetworkUrl = baseUrl + userNetwork
    static let courseFeedbackUrl = baseUrl + courseFeedback
    static let lessonFeedbackUrl = baseUrl + lessonFeedback
    static let lessonCompletedUrl = baseUrl + lessonCompleted
}
