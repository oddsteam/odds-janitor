Feature: Login
    Odds อยากจะเข้าสู่ระบบเพื่อใช้งาน Janitor

    Scenario: เข้าสู่ระบบด้วย Email และ Password ที่ถูกต้อง
        Given ฉันเปิดหน้าเข้าสู่ระบบ
        When ฉันกรอก Email เป็น "test@gmail.com"
        And ฉันกรอก Password เป็น "test_password"
        And ฉันคลิกปุ่มเข้าสู่ระบบ
        Then ฉันจะถูกนำไปยังหน้า Booking