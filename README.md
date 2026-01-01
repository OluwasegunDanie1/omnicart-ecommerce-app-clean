OmniCart – Flutter E-Commerce App

OmniCart is a full-featured e-commerce mobile application built with **Flutter**, **Firebase**, and **Stripe**.  
It includes both **User-facing shopping features** and an **Admin management system** powered by Firebase.

---

Project Overview

OmniCart is a modern Flutter-based e-commerce application designed to simulate a real-world online shopping platform.  
The app supports customer shopping experiences as well as administrative product and order management using Firebase as the backend.

This project demonstrates practical skills in Flutter UI development, Firebase backend services, real-time data handling, and secure payment integration.

---

User Features

- 📦 Product listing from Firebase Firestore  
- 📂 Category-based product filtering  
- 🔍 Product details view  
- 🛒 Add-to-cart with quantity management  
- 🔔 Real-time cart badge updates  
- 💳 Stripe payment integration (**Test Mode**)  
- 📦 Order history tracking  
- 👤 User profile (name & email)  
- 🔥 Real-time updates using Firestore streams  

---

Admin Features (Firebase Backend)

- 🔐 Admin authentication  
- ➕ Add, update, and delete products  
- 🗂️ Manage product categories  
- 📦 View and manage customer orders  
- 👥 View registered users  
- 🔄 Real-time synchronization with Firestore  

> Admin operations are handled securely via Firebase and reflected instantly in the user app.

---

Tech Stack

- **Flutter (Dart)**
- **Firebase Firestore**
- **Firebase Authentication**
- **Stripe Payment Gateway (Test Mode)**
- **Shared Preferences**
- **MVC-style project architecture**

---

Screens Implemented

User Screens
- Splash Screen
- Onboarding Screen
- Login Screen
- Registration Screen
- Home Screen  
- Category Screen  
- Product Details Screen  
- Cart Screen  
- Checkout Screen  
- Orders Screen  
- Profile Screen  

Admin Screens
- Admin Dashboard  
- Product Management Screen  
- Category Management Screen  
- Order Management Screen  

---

Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/omnicart-ecommerce-app.git
2. Install dependencies:

       flutter pub get
3. Create a .env file and add your Stripe key:

       STRIPE_API_KEY=your_stripe_test_key

4. Run the app:

        flutter run

        🔐 Security Notes

Admin access is restricted via Firebase Authentication

Stripe secret keys are stored using environment variables

.env files are excluded from version control

Payment integration runs in test modec

Author

Oladunjoye Segun Daniel
Mobile App Developer (Flutter)

📧 Email: Oluwasegundaniel701@gmail.com

📍 Lagos, Nigeria

License

This project is intended for learning and portfolio purposes.


   
