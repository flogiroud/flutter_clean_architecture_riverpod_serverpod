## Flutter project Structure
```
├── main.dart  
└── src
    ├── config                                                           # Configuration files for app-wide settings like routing, theme, and session management
    │   ├── app_router.dart                                                      # Handles navigation and routing within the app
    │   ├── app_theme.dart                                                       # Defines the app's global theme (colors, fonts, etc.)
    │   ├── client.dart                                                          # Handles client-specific logic or configurations
    │   ├── routes.dart                                                          # Centralizes all the route definitions for navigation
    │   └── session_manager.dart                                                 # Manages user session (login, authentication, etc.)
    ├── data                                                             # Data layer that deals with the repositories, models, and API communication
    │   ├── data_module.dart                                                     # Initializes and provides dependencies for the data layer
    │   ├── models                                                               # Defines the data structures (models) used throughout the app
    │   └── repositories                                                         # Repositories for data retrieval, implementations of API calls
    │       ├── api
    │       │   ├── auth_repository_impl.dart                                    
    │       │   └── user_repository_impl.dart                                    
    │       ├── local                                                            # Local data repositories (e.g., shared preferences, databases)
    │       └── system
    │           └── device_repository_impl.dart                                  # Handles system-level operations like device info retrieval
    ├── domain                                                           # Business logic layer containing use cases, entities, and repository interfaces
    │   ├── domain_module.dart                                                   # Provides dependencies for the domain layer
    │   ├── entities                                                             # Contains domain entities that define the core data models
    │   ├── enums                                                                # Contains enumerations used across the app
    │   │   └── location_status.dart                                             
    │   ├── i_repositories                                                       # Interfaces that define the contracts for repositories
    │   │   ├── i_auth_repository.dart                                           
    │   │   ├── i_device_repository.dart                                         
    │   │   └── i_user_repository.dart                                           
    │   └── use_cases                                                            # Contains the use cases or business logic specific to different app features
    │       ├── auth
    │       │   ├── create_account_request_use_case.dart                         
    │       │   ├── initialite_password_reset_use_case.dart                      
    │       │   ├── log_in_use_case.dart                                         
    │       │   ├── reset_password_use_case.dart                                 
    │       │   ├── sign_out_use_case.dart                                       
    │       │   └── validate_account_use_case.dart                               
    │       ├── camera
    │       │   ├── check_camera_permission_status_use_case.dart                 
    │       │   └── request_camera_permission_use_case.dart                      
    │       ├── location
    │       │   ├── check_location_status_use_case.dart                          
    │       │   ├── open_location_settings_use_case.dart                         
    │       │   └── request_location_permission_use_case.dart                    
    │       └── user
    │           ├── get_user_use_case.dart                                       
    │           ├── update_image_use_case.dart                                   
    │           └── update_pseudo_use_case.dart                                  
    ├── presentation
    │   ├── features                                                             # Contains different app features and their associated UI views and state management
    │   │   ├── forgot_password
    │   │   │   ├── forgot_password_view.dart                                    
    │   │   │   └── notifiers
    │   │   │       ├── forgot_password_notifier.dart                            
    │   │   │       └── forgot_password_step_notifier.dart                       
    │   │   ├── home
    │   │   │   ├── home_view.dart                                               
    │   │   │   └── notifiers
    │   │   │       └── home_notifier.dart                                       
    │   │   ├── join_game
    │   │   │   └── join_game_view.dart                                          
    │   │   ├── launch_game
    │   │   │   ├── launch_game_view.dart                                        
    │   │   │   └── notifiers
    │   │   │       └── camera_permission_notifier.dart                          
    │   │   ├── location_permission
    │   │   │   ├── location_permission_view.dart                                
    │   │   │   └── notifiers
    │   │   │       └── location_permission_notifier.dart                        
    │   │   ├── log_in
    │   │   │   ├── log_in_view.dart                                             
    │   │   │   └── notifiers
    │   │   │       └── log_in_notifier.dart                                     
    │   │   ├── register
    │   │   │   ├── notifiers
    │   │   │   │   ├── register_notifiers.dart                                  
    │   │   │   │   └── register_step_notifier.dart                              
    │   │   │   └── register_view.dart                                           
    │   │   ├── settings
    │   │   │   ├── notifiers
    │   │   │   │   ├── get_user_notifier.dart                                   
    │   │   │   │   ├── sign_out_notifier.dart                                   
    │   │   │   │   ├── update_image_notifier.dart                               
    │   │   │   │   └── update_pseudo_notifier.dart                              
    │   │   │   ├── settings_view.dart                                           
    │   │   │   └── widgets
    │   │   │       └── user_image_handler.dart                                  
    │   │   └── splash
    │   │       └── splash_view.dart                                             
    │   ├── l10n
    │   │   ├── app_en.arb                                                       # English localization file
    │   │   └── app_fr.arb                                                       # French localization file
    │   ├── shared
    │   │   ├── notifiers                                                        # Shared notifiers used across multiple features
    │   │   ├── providers                                                        # Providers used across multiple features
    │   │   │   ├── compass_provider.dart                                        
    │   │   │   ├── home_controller.dart                                         
    │   │   │   └── location_provider.dart                                       
    │   │   └── widgets
    │   │       ├── custom_button.dart                                           
    │   │       ├── custom_error_widget.dart                                     
    │   │       ├── custom_loader.dart                                           
    │   │       ├── custom_text.dart                                             
    │   │       └── custom_text_field.dart                                       
    │   └── utils
    │       └── notifier_error_state_handler.dart                                # Utility for managing error states in notifiers
    └── utils
        ├── constants.dart                                                       # Defines global constants
        ├── custom_exception.dart                                                # Custom exceptions used throughout the app
        ├── error_type.dart                                                      # Defines different error types
        ├── error_type.g.dart                                                    
        └── extensions                                                           # Utility extension methods used across the app

```
For detailed information about the **Flutter implementation**, refer to the official **[Flutter documentation](https://flutter.dev/docs)**.

