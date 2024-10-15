Feature: Login
    Odds อยากจะเข้าสู่ระบบเพื่อใช้งาน Janitor

    Scenario: เข้าสู่ระบบด้วย Email และ Password ที่ถูกต้อง
        Given ฉันเปิดหน้าเข้าสู่ระบบ
        When ฉันกรอก Email เป็น "test@gmail.com"
        And ฉันกรอก Password เป็น "test_password"
        And ฉันคลิกปุ่มเข้าสู่ระบบ
        Then ฉันจะถูกนำไปยังหน้า "Booking"

    Scenario: เข้าสู่ระบบโดยกรอก Email แต่ไม่กรอก Password แล้วไม่สามารถเข้าสู่ระบบได้
        Given ฉันอยู่ที่หน้าเข้าสู่ระบบ
        When ฉันกรอก Email เป็น "test@gmail.com"
        And ฉันคลิกปุ่มเข้าสู่ระบบ
        Then ฉันจะเห็นแจ้งเตือนว่า "Please fill out this field."

    Scenario: เข้าสู่ระบบโดยไม่กรอก Email แต่กรอก Password แล้วไม่สามารถเข้าสู่ระบบได้
        Given ฉันอยู่ที่หน้าเข้าสู่ระบบ
        When ฉันกรอก Password เป็น "test_password"
        And ฉันคลิกปุ่มเข้าสู่ระบบ
        Then ฉันจะเห็นแจ้งเตือนว่า "Please fill out this field."

    Scenario: เข้าสู่ระบบด้วย Email ที่ถูกต้อง แต่ Password ไม่ถูกต้องแล้วไม่สามารถเข้าสู่ระบบได้
        Given ฉันอยู่ที่หน้าเข้าสู่ระบบ
        When ฉันกรอก Email เป็น "test@gmail.com"
        And ฉันกรอก Password เป็น "wrong_password"
        And ฉันคลิกปุ่มเข้าสู่ระบบ
        Then ฉันจะถูกนำไปยังหน้า "Invalid username or password."

    Scenario: เข้าสู่ระบบด้วย Email ที่ไม่ถูกต้อง แต่ Password ถูกต้องแล้วไม่สามารถเข้าสู่ระบบได้
        Given ฉันอยู่ที่หน้าเข้าสู่ระบบ
        When ฉันกรอก Email เป็น "wrong@gmail.com"
        And ฉันกรอก Password เป็น "test_password"
        And ฉันคลิกปุ่มเข้าสู่ระบบ
        Then ฉันจะถูกนำไปยังหน้า "Invalid username or password."