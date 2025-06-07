; Airport Ticketing and Complaint System
; Using Irvine32 Library
; Author: Assembly Developer
; File: FlightTicket&Complaint.asm

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data
    ; Flight structure (200 bytes per flight)
    MAX_FLIGHTS EQU 50
    MAX_TICKETS EQU 100
    MAX_COMPLAINTS EQU 50
    
    ; Flight data arrays
    flightNumbers       BYTE MAX_FLIGHTS DUP(10 DUP(?))     ; Flight numbers
    airlines            BYTE MAX_FLIGHTS DUP(20 DUP(?))     ; Airline names
    sources             BYTE MAX_FLIGHTS DUP(20 DUP(?))     ; Source cities
    destinations        BYTE MAX_FLIGHTS DUP(20 DUP(?))     ; Destination cities
    departureTimes      BYTE MAX_FLIGHTS DUP(10 DUP(?))     ; Departure times
    arrivalTimes        BYTE MAX_FLIGHTS DUP(10 DUP(?))     ; Arrival times
    flightDates         BYTE MAX_FLIGHTS DUP(12 DUP(?))     ; Flight dates
    flightPrices        DWORD MAX_FLIGHTS DUP(?)            ; Flight prices
    totalSeats          DWORD MAX_FLIGHTS DUP(?)            ; Total seats
    availableSeats      DWORD MAX_FLIGHTS DUP(?)            ; Available seats
    flightActive        BYTE MAX_FLIGHTS DUP(?)             ; Active flag (1=active, 0=deleted)
    flightCount         DWORD 0
    
    ; Ticket data arrays
    ticketIDs           DWORD MAX_TICKETS DUP(?)            ; Ticket IDs
    ticketFlightNums    BYTE MAX_TICKETS DUP(10 DUP(?))     ; Flight numbers for tickets
    customerNames       BYTE MAX_TICKETS DUP(30 DUP(?))     ; Customer names
    customerPhones      BYTE MAX_TICKETS DUP(15 DUP(?))     ; Customer phones
    customerEmails      BYTE MAX_TICKETS DUP(50 DUP(?))     ; Customer emails
    ticketPrices        DWORD MAX_TICKETS DUP(?)            ; Ticket prices
    ticketActive        BYTE MAX_TICKETS DUP(?)             ; Ticket status
    ticketCount         DWORD 0
    nextTicketID        DWORD 1001
    
    ; Complaint data arrays
    complaintIDs        DWORD MAX_COMPLAINTS DUP(?)         ; Complaint IDs
    complaintCategories BYTE MAX_COMPLAINTS DUP(20 DUP(?))  ; Categories
    complaintDetails    BYTE MAX_COMPLAINTS DUP(200 DUP(?)) ; Complaint details
    complaintNames      BYTE MAX_COMPLAINTS DUP(30 DUP(?))  ; Customer names
    complaintResponses  BYTE MAX_COMPLAINTS DUP(200 DUP(?)) ; Admin responses
    complaintStatus     BYTE MAX_COMPLAINTS DUP(?)          ; Status (0=pending, 1=resolved)
    complaintCount      DWORD 0
    nextComplaintID     DWORD 5001
    
    ; Menu strings
    mainMenuTitle       BYTE "=== AIRPORT TICKETING & COMPLAINT SYSTEM ===", 0dh, 0ah, 0
    mainMenu            BYTE "1. Admin Panel", 0dh, 0ah
                        BYTE "2. Book Ticket", 0dh, 0ah
                        BYTE "3. View My Tickets", 0dh, 0ah
                        BYTE "4. Cancel Ticket", 0dh, 0ah
                        BYTE "5. File Complaint", 0dh, 0ah
                        BYTE "6. View Available Flights", 0dh, 0ah
                        BYTE "7. Search Ticket", 0dh, 0ah
                        BYTE "0. Exit", 0dh, 0ah
                        BYTE "Enter choice: ", 0
    
    adminMenuTitle      BYTE "=== ADMIN PANEL ===", 0dh, 0ah, 0
    adminMenu           BYTE "1. Add Flight", 0dh, 0ah
                        BYTE "2. View All Flights", 0dh, 0ah
                        BYTE "3. Update Flight", 0dh, 0ah
                        BYTE "4. Delete Flight", 0dh, 0ah
                        BYTE "5. View Complaints", 0dh, 0ah
                        BYTE "6. Respond to Complaint", 0dh, 0ah
                        BYTE "0. Back to Main Menu", 0dh, 0ah
                        BYTE "Enter choice: ", 0
    
    ; Input prompts
    promptFlightNum     BYTE "Enter Flight Number: ", 0
    promptAirline       BYTE "Enter Airline: ", 0
    promptSource        BYTE "Enter Source City: ", 0
    promptDestination   BYTE "Enter Destination City: ", 0
    promptDepartTime    BYTE "Enter Departure Time (HH:MM): ", 0
    promptArriveTime    BYTE "Enter Arrival Time (HH:MM): ", 0
    promptDate          BYTE "Enter Date (DD/MM/YYYY): ", 0
    promptPrice         BYTE "Enter Price: $", 0
    promptSeats         BYTE "Enter Total Seats: ", 0
    promptName          BYTE "Enter Your Name: ", 0
    promptPhone         BYTE "Enter Phone Number: ", 0
    promptEmail         BYTE "Enter Email: ", 0
    promptTicketID      BYTE "Enter Ticket ID: ", 0
    promptComplaintCat  BYTE "Enter Complaint Category (Delay/Service/Baggage/Other): ", 0
    promptComplaintDet  BYTE "Enter Complaint Details: ", 0
    promptComplaintID   BYTE "Enter Complaint ID: ", 0
    promptResponse      BYTE "Enter Response: ", 0
    
    ; Messages
    msgFlightAdded      BYTE "Flight added successfully!", 0dh, 0ah, 0
    msgFlightUpdated    BYTE "Flight updated successfully!", 0dh, 0ah, 0
    msgFlightDeleted    BYTE "Flight deleted successfully!", 0dh, 0ah, 0
    msgFlightNotFound   BYTE "Flight not found!", 0dh, 0ah, 0
    msgTicketBooked     BYTE "Ticket booked successfully! Your Ticket ID: ", 0
    msgTicketCanceled   BYTE "Ticket canceled successfully!", 0dh, 0ah, 0
    msgTicketNotFound   BYTE "Ticket not found!", 0dh, 0ah, 0
    msgNoSeats          BYTE "No seats available!", 0dh, 0ah, 0
    msgComplaintFiled   BYTE "Complaint filed successfully! Your Complaint ID: ", 0
    msgNoFlights        BYTE "No flights available!", 0dh, 0ah, 0
    msgNoTickets        BYTE "No tickets found!", 0dh, 0ah, 0
    msgNoComplaints     BYTE "No complaints found!", 0dh, 0ah, 0
    msgInvalidChoice    BYTE "Invalid choice! Please try again.", 0dh, 0ah, 0
    msgPressEnter       BYTE "Press Enter to continue...", 0
    msgComplaintUpdated BYTE "Complaint response added successfully!", 0dh, 0ah, 0
    
    ; Headers
    headerFlights       BYTE "Flight# | Airline     | Source      | Destination | Date       | Time  | Price | Seats", 0dh, 0ah
                        BYTE "--------|-------------|-------------|-------------|------------|-------|-------|------", 0dh, 0ah, 0
    headerTickets       BYTE "Ticket ID | Flight# | Name         | Phone      | Price", 0dh, 0ah
                        BYTE "----------|---------|--------------|------------|------", 0dh, 0ah, 0
    headerComplaints    BYTE "ID   | Category | Customer     | Status  | Details", 0dh, 0ah
                        BYTE "-----|----------|--------------|---------|--------", 0dh, 0ah, 0
    
    ; Temporary input buffers
    tempBuffer          BYTE 200 DUP(?)
    tempNumber          DWORD ?
    tempChoice          DWORD ?
    
    ; Admin password
    adminPassword       BYTE "admin123", 0
    inputPassword       BYTE 20 DUP(?)
    promptPassword      BYTE "Enter admin password: ", 0
    msgWrongPassword    BYTE "Wrong password!", 0dh, 0ah, 0
    
    newline             BYTE 0dh, 0ah, 0
    space               BYTE " ", 0
    pipe                BYTE " | ", 0
    dollar              BYTE "$", 0
    statusPending       BYTE "Pending", 0
    statusResolved      BYTE "Resolved", 0

.code
main PROC
    call Clrscr
    
MainLoop:
    call ShowMainMenu
    call ReadDec
    mov tempChoice, eax
    
    cmp eax, 0
    je ExitProgram
    cmp eax, 1
    je AdminPanel
    cmp eax, 2
    je BookTicket
    cmp eax, 3
    je ViewMyTickets
    cmp eax, 4
    je CancelTicket
    cmp eax, 5
    je FileComplaint
    cmp eax, 6
    je ViewAvailableFlights
    cmp eax, 7
    je SearchTicket
    
    ; Invalid choice
    mov edx, OFFSET msgInvalidChoice
    call WriteString
    call MyWaitMsg
    jmp MainLoop

AdminPanel:
    call CheckAdminPassword
    cmp eax, 0
    je MainLoop
    call ShowAdminMenu
    jmp MainLoop

BookTicket:
    call BookFlightTicket
    jmp MainLoop

ViewMyTickets:
    call ViewTicketHistory
    jmp MainLoop

CancelTicket:
    call CancelFlightTicket
    jmp MainLoop

FileComplaint:
    call FileCustomerComplaint
    jmp MainLoop

ViewAvailableFlights:
    call DisplayAvailableFlights
    jmp MainLoop

SearchTicket:
    call SearchTicketByID
    jmp MainLoop

ExitProgram:
    exit
main ENDP

; Show main menu
ShowMainMenu PROC
    call Clrscr
    mov edx, OFFSET mainMenuTitle
    call WriteString
    mov edx, OFFSET mainMenu
    call WriteString
    ret
ShowMainMenu ENDP

; Check admin password
CheckAdminPassword PROC
    mov edx, OFFSET promptPassword
    call WriteString
    mov edx, OFFSET inputPassword
    mov ecx, SIZEOF inputPassword
    call ReadString
    
    ; Compare passwords
    mov esi, OFFSET inputPassword
    mov edi, OFFSET adminPassword
    mov ecx, 8
    repe cmpsb
    je PasswordCorrect
    
    mov edx, OFFSET msgWrongPassword
    call WriteString
    call MyWaitMsg
    mov eax, 0
    ret
    
PasswordCorrect:
    mov eax, 1
    ret
CheckAdminPassword ENDP

; Show admin menu
ShowAdminMenu PROC
AdminMenuLoop:
    call Clrscr
    mov edx, OFFSET adminMenuTitle
    call WriteString
    mov edx, OFFSET adminMenu
    call WriteString
    call ReadDec
    
    cmp eax, 0
    je AdminMenuExit
    cmp eax, 1
    je AddFlight
    cmp eax, 2
    je ViewAllFlights
    cmp eax, 3
    je UpdateFlight
    cmp eax, 4
    je DeleteFlight
    cmp eax, 5
    je ViewComplaints
    cmp eax, 6
    je RespondComplaint
    
    mov edx, OFFSET msgInvalidChoice
    call WriteString
    call MyWaitMsg
    jmp AdminMenuLoop

AddFlight:
    call AddNewFlight
    jmp AdminMenuLoop

ViewAllFlights:
    call DisplayAllFlights
    jmp AdminMenuLoop

UpdateFlight:
    call UpdateFlightDetails
    jmp AdminMenuLoop

DeleteFlight:
    call DeleteFlightRecord
    jmp AdminMenuLoop

ViewComplaints:
    call DisplayComplaints
    jmp AdminMenuLoop

RespondComplaint:
    call RespondToComplaint
    jmp AdminMenuLoop

AdminMenuExit:
    ret
ShowAdminMenu ENDP

; Add new flight
AddNewFlight PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    ; Check if we can add more flights
    mov eax, flightCount
    cmp eax, MAX_FLIGHTS
    jae FlightLimitReached
    
    call Clrscr
    mov edx, OFFSET promptFlightNum
    call WriteString
    
    ; Calculate offset for new flight
    mov eax, flightCount
    mov ebx, 10
    mul ebx
    mov edi, eax
    add edi, OFFSET flightNumbers
    
    mov edx, edi
    mov ecx, 10
    call ReadString
    
    ; Add airline
    mov edx, OFFSET promptAirline
    call WriteString
    mov eax, flightCount
    mov ebx, 20
    mul ebx
    mov edi, eax
    add edi, OFFSET airlines
    mov edx, edi
    mov ecx, 20
    call ReadString
    
    ; Add source
    mov edx, OFFSET promptSource
    call WriteString
    mov eax, flightCount
    mov ebx, 20
    mul ebx
    mov edi, eax
    add edi, OFFSET sources
    mov edx, edi
    mov ecx, 20
    call ReadString
    
    ; Add destination
    mov edx, OFFSET promptDestination
    call WriteString
    mov eax, flightCount
    mov ebx, 20
    mul ebx
    mov edi, eax
    add edi, OFFSET destinations
    mov edx, edi
    mov ecx, 20
    call ReadString
    
    ; Add departure time
    mov edx, OFFSET promptDepartTime
    call WriteString
    mov eax, flightCount
    mov ebx, 10
    mul ebx
    mov edi, eax
    add edi, OFFSET departureTimes
    mov edx, edi
    mov ecx, 10
    call ReadString
    
    ; Add arrival time
    mov edx, OFFSET promptArriveTime
    call WriteString
    mov eax, flightCount
    mov ebx, 10
    mul ebx
    mov edi, eax
    add edi, OFFSET arrivalTimes
    mov edx, edi
    mov ecx, 10
    call ReadString
    
    ; Add date
    mov edx, OFFSET promptDate
    call WriteString
    mov eax, flightCount
    mov ebx, 12
    mul ebx
    mov edi, eax
    add edi, OFFSET flightDates
    mov edx, edi
    mov ecx, 12
    call ReadString
    
    ; Add price
    mov edx, OFFSET promptPrice
    call WriteString
    call ReadDec
    mov ebx, flightCount
    mov flightPrices[ebx*4], eax
    
    ; Add seats
    mov edx, OFFSET promptSeats
    call WriteString
    call ReadDec
    mov ebx, flightCount
    mov totalSeats[ebx*4], eax
    mov availableSeats[ebx*4], eax
    
    ; Set flight as active
    mov ebx, flightCount
    mov flightActive[ebx], 1
    
    ; Increment flight count
    inc flightCount
    
    mov edx, OFFSET msgFlightAdded
    call WriteString
    call MyWaitMsg
    jmp AddFlightEnd

FlightLimitReached:
    mov edx, OFFSET msgNoFlights
    call WriteString
    call MyWaitMsg

AddFlightEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
AddNewFlight ENDP

; Display all flights
DisplayAllFlights PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    mov edx, OFFSET headerFlights
    call WriteString
    
    mov ecx, flightCount
    cmp ecx, 0
    je NoFlightsToShow
    
    mov esi, 0
    
DisplayFlightLoop:
    ; Check if flight is active
    cmp flightActive[esi], 1
    jne SkipFlight
    
    ; Display flight number
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET flightNumbers
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display airline
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET airlines
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display source
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET sources
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display destination
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET destinations
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display date
    mov eax, esi
    mov ebx, 12
    mul ebx
    add eax, OFFSET flightDates
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display departure time
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET departureTimes
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display price
    mov edx, OFFSET dollar
    call WriteString
    mov eax, flightPrices[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display available seats
    mov eax, availableSeats[esi*4]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString

SkipFlight:
    inc esi
    dec ecx
jnz DisplayFlightLoop
    
    call MyWaitMsg
    jmp DisplayFlightsEnd

NoFlightsToShow:
    mov edx, OFFSET msgNoFlights
    call WriteString
    call MyWaitMsg

DisplayFlightsEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayAllFlights ENDP

; Display available flights for booking
DisplayAvailableFlights PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    mov edx, OFFSET headerFlights
    call WriteString
    
    mov ecx, flightCount
    cmp ecx, 0
    je NoAvailableFlights
    
    mov esi, 0
    
DisplayAvailableLoop:
    ; Check if flight is active and has seats
    cmp flightActive[esi], 1
    jne SkipAvailableFlight
    cmp availableSeats[esi*4], 0
    je SkipAvailableFlight
    
    ; Display flight details (same as DisplayAllFlights)
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET flightNumbers
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET airlines
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET sources
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET destinations
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 12
    mul ebx
    add eax, OFFSET flightDates
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET departureTimes
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov edx, OFFSET dollar
    call WriteString
    mov eax, flightPrices[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, availableSeats[esi*4]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString

SkipAvailableFlight:
    inc esi
    dec ecx
jnz DisplayAvailableLoop
    
    call MyWaitMsg
    jmp DisplayAvailableEnd

NoAvailableFlights:
    mov edx, OFFSET msgNoFlights
    call WriteString
    call MyWaitMsg

DisplayAvailableEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayAvailableFlights ENDP

; Book a flight ticket
BookFlightTicket PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    ; First show available flights
    call DisplayAvailableFlights
    
    ; Check if we can add more tickets
    mov eax, ticketCount
    cmp eax, MAX_TICKETS
    jae TicketLimitReached
    
    ; Get flight number to book
    mov edx, OFFSET promptFlightNum
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, SIZEOF tempBuffer
    call ReadString
    
    ; Find the flight
    call FindFlightByNumber
    cmp eax, -1
    ; je FlightNotFoundForBooking ; Original line 537 - Jump too far
    jne L_BookTicket_Continue_537  ; If flight found (eax != -1), continue
    jmp FlightNotFoundForBooking ; If flight not found (eax == -1), jump to error handling
L_BookTicket_Continue_537:
    
    ; Check if seats available
    mov ebx, eax
    cmp availableSeats[ebx*4], 0
    je NoSeatsAvailable
    
    ; Get customer details
    mov edx, OFFSET promptName
    call WriteString
    mov eax, ticketCount
    imul eax, eax, 30
    add eax, OFFSET customerNames
    mov edx, eax
    mov ecx, 30
    call ReadString
    
    mov edx, OFFSET promptPhone
    call WriteString
    mov eax, ticketCount
    imul eax, eax, 15
    add eax, OFFSET customerPhones
    mov edx, eax
    mov ecx, 15
    call ReadString
    
    mov edx, OFFSET promptEmail
    call WriteString
    mov eax, ticketCount
    imul eax, eax, 50
    add eax, OFFSET customerEmails
    mov edx, eax
    mov ecx, 50
    call ReadString
    
    ; Set ticket details
    mov eax, nextTicketID
    mov ebx, ticketCount
    mov ticketIDs[ebx*4], eax
    inc nextTicketID
    
    ; Copy flight number to ticket
    mov esi, OFFSET tempBuffer
    mov eax, ticketCount
    imul eax, eax, 10
    add eax, OFFSET ticketFlightNums
    mov edi, eax
    mov ecx, 10
    rep movsb
    
    ; Set ticket price and status
    call FindFlightByNumber ; Re-find flight to get its index for price (tempBuffer still holds flight num)
    mov ebx, eax ; ebx = flight index
    mov eax, flightPrices[ebx*4]
    mov ebx, ticketCount
    mov ticketPrices[ebx*4], eax
    mov ticketActive[ebx], 1
    
    ; Decrease available seats
    call FindFlightByNumber ; Re-find flight again for seat decrement
    mov ebx, eax ; ebx = flight index
    dec availableSeats[ebx*4]
    
    ; Increment ticket count
    inc ticketCount
    
    ; Show success message with ticket ID
    mov edx, OFFSET msgTicketBooked
    call WriteString
    mov eax, ticketCount
    dec eax
    imul eax, eax, 4
    mov eax, ticketIDs[eax]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString
    call MyWaitMsg
    jmp BookTicketEnd

FlightNotFoundForBooking:
    mov edx, OFFSET msgFlightNotFound
    call WriteString
    call MyWaitMsg
    jmp BookTicketEnd

NoSeatsAvailable:
    mov edx, OFFSET msgNoSeats
    call WriteString
    call MyWaitMsg
    jmp BookTicketEnd

TicketLimitReached:
    mov edx, OFFSET msgNoTickets
    call WriteString
    call MyWaitMsg

BookTicketEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
BookFlightTicket ENDP
; Find flight by number - returns index in EAX, -1 if not found
FindFlightByNumber PROC
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov ecx, flightCount
    cmp ecx, 0
    je FlightNotFoundInSearch_DirectExit ; Renamed to avoid conflict if it was the target
    
    mov esi, 0 ; Initialize index for flight iteration
    
FindFlightLoop:
    ; Check if flight is active
    cmp flightActive[esi], 1
    jne NextFlightSearch
    
    ; Compare flight numbers
    ; Need to preserve esi (loop counter) if it's used by repe cmpsb indirectly
    ; Here, edi will point to flightNumbers[esi*10] and temp_esi to tempBuffer
    push esi ; Save main loop index
    mov eax, esi ; current flight index
    mov ebx, 10
    mul ebx
    add eax, OFFSET flightNumbers
    mov edi, eax            ; edi points to flightNumbers[current_flight_index]
    
    mov esi, OFFSET tempBuffer ; esi points to user input flight number
    
    push ecx ; Save outer loop counter for flightCount
    mov ecx, 10 ; Length of flight number string
    repe cmpsb
    pop ecx ; Restore outer loop counter
    
    pop esi ; Restore main loop index

    je FlightFoundInSearch ; If cmpsb found a match (ZF=1)
    
NextFlightSearch:
    inc esi
    mov eax, esi ; Prepare for comparison with flightCount
    cmp eax, flightCount
    jl FindFlightLoop

FlightNotFoundInSearch_DirectExit: ; Label for when flightCount is 0 or loop finishes
    mov eax, -1
    jmp FindFlightEnd

FlightFoundInSearch:
    mov eax, esi  ; Return the index (which is in esi)
    ; jmp FindFlightEnd ; This jump is implicit as it's the next line effectively

FindFlightEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
FindFlightByNumber ENDP
; View ticket history
ViewTicketHistory PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    mov edx, OFFSET headerTickets
    call WriteString
    
    mov ecx, ticketCount
    cmp ecx, 0
    je NoTicketsToShow
    
    mov esi, 0
    
ViewTicketLoop:
    cmp ticketActive[esi], 1
    jne SkipTicket
    
    ; Display ticket ID
    mov eax, ticketIDs[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display flight number
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET ticketFlightNums
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display customer name
    mov eax, esi
    mov ebx, 30
    mul ebx
    add eax, OFFSET customerNames
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display phone
    mov eax, esi
    mov ebx, 15
    mul ebx
    add eax, OFFSET customerPhones
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display price
    mov edx, OFFSET dollar
    call WriteString
    mov eax, ticketPrices[esi*4]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString

SkipTicket:
    inc esi
    dec ecx
jnz ViewTicketLoop
    
    call MyWaitMsg
    jmp ViewTicketEnd

NoTicketsToShow:
    mov edx, OFFSET msgNoTickets
    call WriteString
    call MyWaitMsg

ViewTicketEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
ViewTicketHistory ENDP

; Cancel flight ticket
CancelFlightTicket PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET promptTicketID
    call WriteString
    call ReadDec
    mov tempNumber, eax
    
    ; Find ticket by ID
    mov ecx, ticketCount
    cmp ecx, 0
    ; je TicketNotFoundForCancel ; Original line 650 - Jump too far
    jne L_CancelTicket_Continue_650 ; If ticketCount > 0, proceed to search
    jmp TicketNotFoundForCancel ; If ticketCount == 0, jump to not found
L_CancelTicket_Continue_650:
    
    mov esi, 0
    
FindTicketLoop_Cancel: ; Renamed to avoid conflict
    mov eax, ticketIDs[esi*4]
    cmp eax, tempNumber
    je TicketFoundForCancel
    inc esi
    loop FindTicketLoop_Cancel ; Use the new label
    
    ; If loop finishes, ticket not found, fall through or jmp to TicketNotFoundForCancel
    jmp TicketNotFoundForCancel ; Explicit jump if loop finishes

TicketNotFoundForCancel:
    mov edx, OFFSET msgTicketNotFound
    call WriteString
    call MyWaitMsg
    jmp CancelTicketEnd

TicketFoundForCancel:
    ; Check if ticket is active
    cmp ticketActive[esi], 0
    je TicketNotFoundForCancel ; This jump might also be too far, but not reported.
    
    ; Mark ticket as canceled
    mov ticketActive[esi], 0
    
    ; Increase available seats for the flight
    ; Copy flight number from ticket to tempBuffer to use FindFlightByNumber
    push edi ; Save edi
    mov eax, esi ; current ticket index in esi
    imul eax, eax, 10
    add eax, OFFSET ticketFlightNums ; eax points to ticketFlightNums[current_ticket_index]
    
    mov edi, OFFSET tempBuffer ; edi points to tempBuffer
    push esi ; Save current ticket index (esi)
    mov esi, eax ; esi now source for rep movsb
    push ecx ; Save loop counter for FindTicketLoop_Cancel if any
    mov ecx, 10 ; Length of flight number
    rep movsb
    pop ecx
    pop esi ; Restore current ticket index to esi
    pop edi ; Restore edi
    
    call FindFlightByNumber ; tempBuffer now has the flight number
    cmp eax, -1
    je TicketCancelSuccess ; If flight not found (e.g. deleted), just mark ticket cancelled
    mov ebx, eax ; ebx = flight index
    inc availableSeats[ebx*4]
    
TicketCancelSuccess:
    mov edx, OFFSET msgTicketCanceled
    call WriteString
    call MyWaitMsg

CancelTicketEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
CancelFlightTicket ENDP

; Search ticket by ID
SearchTicketByID PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET promptTicketID
    call WriteString
    call ReadDec
    mov tempNumber, eax
    
    ; Find ticket by ID
    mov ecx, ticketCount
    cmp ecx, 0
    ; je TicketNotFoundForSearch ; Original line 921 - Jump too far
    jne L_SearchTicket_Continue_921 ; If ticketCount > 0, proceed to search
    jmp TicketNotFoundForSearch ; If ticketCount == 0, jump to not found
L_SearchTicket_Continue_921:
    
    mov esi, 0
    
SearchTicketLoop_ByID: ; Renamed to avoid conflict
    mov eax, ticketIDs[esi*4]
    cmp eax, tempNumber
    je TicketFoundForSearch
    inc esi
    loop SearchTicketLoop_ByID ; Use the new label
    
    ; If loop finishes, ticket not found, fall through or jmp to TicketNotFoundForSearch
    jmp TicketNotFoundForSearch ; Explicit jump if loop finishes

TicketNotFoundForSearch:
    mov edx, OFFSET msgTicketNotFound
    call WriteString
    call MyWaitMsg
    jmp SearchTicketEnd

TicketFoundForSearch:
    ; Check if ticket is active
    cmp ticketActive[esi], 0
    je TicketNotFoundForSearch ; This jump might also be too far, but not reported.
    
    ; Display ticket details
    call Clrscr
    mov edx, OFFSET headerTickets
    call WriteString
    
    ; Display ticket ID
    mov eax, ticketIDs[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display flight number
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET ticketFlightNums
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display customer name
    mov eax, esi
    mov ebx, 30
    mul ebx
    add eax, OFFSET customerNames
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display phone
    mov eax, esi
    mov ebx, 15
    mul ebx
    add eax, OFFSET customerPhones
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display price
    mov edx, OFFSET dollar
    call WriteString
    mov eax, ticketPrices[esi*4]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString
    
    call MyWaitMsg

SearchTicketEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
SearchTicketByID ENDP

; File a complaint
FileCustomerComplaint PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    ; Check if we can add more complaints
    mov eax, complaintCount
    cmp eax, MAX_COMPLAINTS
    jae ComplaintLimitReached
    
    call Clrscr
    
    ; Get customer name
    mov edx, OFFSET promptName
    call WriteString
    mov eax, complaintCount
    imul eax, eax, 30
    add eax, OFFSET complaintNames
    mov edx, eax
    mov ecx, 30
    call ReadString
    
    ; Get complaint category
    mov edx, OFFSET promptComplaintCat
    call WriteString
    mov eax, complaintCount
    imul eax, eax, 20
    add eax, OFFSET complaintCategories
    mov edx, eax
    mov ecx, 20
    call ReadString
    
    ; Get complaint details
    mov edx, OFFSET promptComplaintDet
    call WriteString
    mov eax, complaintCount
    imul eax, eax, 200
    add eax, OFFSET complaintDetails
    mov edx, eax
    mov ecx, 200
    call ReadString
    
    ; Set complaint ID and status
    mov eax, nextComplaintID
    mov ebx, complaintCount
    mov complaintIDs[ebx*4], eax
    inc nextComplaintID
    mov complaintStatus[ebx], 0  ; 0 = pending
    
    ; Clear response
    mov eax, complaintCount
    imul eax, eax, 200
    add eax, OFFSET complaintResponses
    mov edi, eax
    push ecx ; Save ecx if it's important before this, though ReadString usually sets it to bytes read
    mov ecx, 200
    mov al, 0
    rep stosb
    pop ecx
    
    ; Increment complaint count
    inc complaintCount
    
    ; Show success message
    mov edx, OFFSET msgComplaintFiled
    call WriteString
    mov eax, complaintCount
    dec eax
    imul eax, eax, 4
    mov eax, complaintIDs[eax]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString
    call MyWaitMsg
    jmp FileComplaintEnd

ComplaintLimitReached:
    mov edx, OFFSET msgNoComplaints
    call WriteString
    call MyWaitMsg

FileComplaintEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
FileCustomerComplaint ENDP

; Display complaints (Admin function)
DisplayComplaints PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    mov edx, OFFSET headerComplaints
    call WriteString
    
    mov ecx, complaintCount
    cmp ecx, 0
    je NoComplaintsToShow
    
    mov esi, 0
    
DisplayComplaintLoop:
    ; Display complaint ID
    mov eax, complaintIDs[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display category
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET complaintCategories
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display customer name
    mov eax, esi
    mov ebx, 30
    mul ebx ; Corrected from imul ebx to mul ebx (assuming eax holds index esi)
    add eax, OFFSET complaintNames
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display status
    cmp complaintStatus[esi], 0
    je ShowPending
    mov edx, OFFSET statusResolved
    jmp ShowStatus
ShowPending:
    mov edx, OFFSET statusPending
ShowStatus:
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    ; Display details (truncated)
    mov eax, esi
    mov ebx, 200
    mul ebx ; Corrected from imul ebx to mul ebx
    add eax, OFFSET complaintDetails
    mov edx, eax
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    
    inc esi
    dec ecx
jnz DisplayComplaintLoop
    
    call MyWaitMsg
    jmp DisplayComplaintsEnd

NoComplaintsToShow:
    mov edx, OFFSET msgNoComplaints
    call WriteString
    call MyWaitMsg

DisplayComplaintsEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayComplaints ENDP

; Respond to complaint (Admin function)
RespondToComplaint PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET promptComplaintID
    call WriteString
    call ReadDec
    mov tempNumber, eax
    
    ; Find complaint by ID
    mov ecx, complaintCount
    cmp ecx, 0
    je FindComplaintNotFound
    
    mov esi, 0
    
FindComplaintSearchLoop:
    mov eax, complaintIDs[esi*4]
    cmp eax, tempNumber
    je FindComplaintFound
    inc esi
    loop FindComplaintSearchLoop
    jmp FindComplaintNotFound ; If loop finishes, not found
    
FindComplaintNotFound:
    mov edx, OFFSET msgNoComplaints ; Assuming this is the correct message for "complaint not found"
    call WriteString
    call MyWaitMsg
    jmp RespondComplaintEnd

FindComplaintFound:
    ; Get response
    mov edx, OFFSET promptResponse
    call WriteString
    mov eax, esi
    mov ebx, 200
    mul ebx ; Corrected from imul ebx to mul ebx
    add eax, OFFSET complaintResponses
    mov edx, eax
    mov ecx, 200
    call ReadString
    
    ; Mark as resolved
    mov complaintStatus[esi], 1
    
    mov edx, OFFSET msgComplaintUpdated
    call WriteString
    call MyWaitMsg

RespondComplaintEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
RespondToComplaint ENDP

; Update flight details
UpdateFlightDetails PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov edx, OFFSET promptFlightNum
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, SIZEOF tempBuffer
    call ReadString
    
    call FindFlightByNumber
    cmp eax, -1
    ; je FlightNotFoundForUpdate ; Original line 1272 - Jump too far
    jne L_UpdateFlight_Continue_1272 ; If flight found, continue
    jmp FlightNotFoundForUpdate ; If not found, jump to error handling
L_UpdateFlight_Continue_1272:
    
    mov esi, eax  ; Store flight index
    
    ; Update price
    mov edx, OFFSET promptPrice
    call WriteString
    call ReadDec
    mov flightPrices[esi*4], eax
    
    ; Update departure time
    mov edx, OFFSET promptDepartTime
    call WriteString
    mov eax, esi
    mov ebx, 10
    mul ebx ; Corrected from imul ebx to mul ebx
    add eax, OFFSET departureTimes
    mov edx, eax
    mov ecx, 10
    call ReadString
    
    mov edx, OFFSET msgFlightUpdated
    call WriteString
    call MyWaitMsg
    jmp UpdateFlightEnd

FlightNotFoundForUpdate:
    mov edx, OFFSET msgFlightNotFound
    call WriteString
    call MyWaitMsg

UpdateFlightEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
UpdateFlightDetails ENDP

; Delete flight record
DeleteFlightRecord PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET promptFlightNum
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, SIZEOF tempBuffer
    call ReadString
    
    call FindFlightByNumber
    cmp eax, -1
    je FlightNotFoundForDelete
    
    ; Mark flight as inactive
    mov esi, eax
    mov flightActive[esi], 0
    
    mov edx, OFFSET msgFlightDeleted
    call WriteString
    call MyWaitMsg
    jmp DeleteFlightEnd

FlightNotFoundForDelete:
    mov edx, OFFSET msgFlightNotFound
    call WriteString
    call MyWaitMsg

DeleteFlightEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DeleteFlightRecord ENDP

MyWaitMsg PROC
    push edx
    mov edx, OFFSET msgPressEnter
    call WriteString
    call ReadChar
    pop edx
    ret
MyWaitMsg ENDP

END main
