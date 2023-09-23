## HW01_Chatbot

chatbot_m <- function(){
  print("Welcome to MV pizza chatbot")
  print("Can you talk with a MV pizza chatbot")
  print("Instruction: type 'exit' to exit for the chatbot")
  
  while(TRUE){
    cat("Did you make a reservation?: ")
    user <- readLines("stdin", 1)
    if(user == "exit"){
      print("Thank you for using MV pizza chatbot.")
      break
    } else {
      print("This way please and this is a menu.")
      cat("Can I recommend the favorite menu for our restaurant?: ")
      waiter <- readLines("stdin", 1)
    }
    if(waiter == "exit"){
      print("Thank you for using MV pizza chatbot.")
      break
    } else {
      print("We have a signature pizza, chicken, spaghetti, soups, drinks")
      cat("What menu do you want?: ")
      p_menu <- readLines("stdin", 1)
    }
    if(p_menu == "exit"){
      print("Thank you for using MV pizza chatbot.")
      break
    } else {
      print(p_menu)
      cat("the signature pizza have thick, thin, cheese dough. what do you want?: ")
      p_dough <- readLines("stdin", 1)
    }
    if(p_dough == "exit"){
      print("Thank you for using MV pizza chatbot.")
      break
    } else {
      print(p_dough)
      cat("Do you want meat, seafood, vegetable for this pizza: ")
      p_type <- readLines("stdin", 1)
    }
    if(p_type == "exit"){
      print("Thank you for using MV pizza chatbot.")
      break
    } else {
      print(p_type)
      cat("What spicy level about do you want? we have low, medium, high.: ")
      p_spicy <- readLines("stdin", 1)
    }
    if(p_spicy == "exit"){
      print("Thank you for using MV pizza chatbot.")
      break
    } else {
      print(p_spicy)
      cat("Thank you. Please wait order about 15mins: ")
      p_end <- readLines("stdin", 1)
    }
    if(p_end == "exit"){
      print("Thank you for using MV pizza chatbot.")
      break
    } else {
      print("Thank you for using please exit or play again ")
    }
  }  
}
   
chatbot_m()
