# ms_crm_backend

# 🖥️ CRM Backend (Django REST API)

## 📌 Overview

This is the backend service for the CRM Management System built with:

-   Django
-   Django REST Framework
-   SimpleJWT Authentication
-   MySQL Database

Provides secure REST APIs for authentication, roles, proposals, sales,
and expenses.

------------------------------------------------------------------------

## ⚙️ Requirements

-   Python 3.10+
-   MySQL
-   pip
-   virtualenv (recommended)

------------------------------------------------------------------------

## 🚀 Installation Guide

### 1️⃣ Navigate to backend folder

``` bash
cd ms_crm_backend
```

### 2️⃣ Create virtual environment

``` bash
python -m venv venv
```

### 3️⃣ Activate environment

**Windows**

``` bash
venv\Scripts\activate
```

**Mac/Linux**

``` bash
source venv/bin/activate
```

### 4️⃣ Install dependencies

``` bash
pip install -r requirements.txt
```

### 5️⃣ Configure Database (settings.py)

``` python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'your_db_name',
        'USER': 'your_db_user',
        'PASSWORD': 'your_password',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

### 6️⃣ Run migrations

``` bash
python manage.py makemigrations
python manage.py migrate
```

### 7️⃣ Start server

``` bash
python manage.py runserver
```

Backend runs at: http://127.0.0.1:8000/

------------------------------------------------------------------------

## 🔐 Authentication Flow

-   Login returns Access & Refresh tokens
-   JWT required in header:

```{=html}
<!-- -->
```
    Authorization: Bearer <access_token>

-   Token refresh supported
-   Role-based login restriction (Approved / Pending)

------------------------------------------------------------------------

## 🛠️ Backend Features

-   JWT Authentication
-   Role-Based Access Control
-   Optimized ORM Queries
-   Secure API Endpoints
-   Sales & Expense APIs

------------------------------------------------------------------------

## 📄 License

Magnyte Software Solution License
