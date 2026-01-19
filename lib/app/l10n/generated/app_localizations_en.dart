// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Turbo';

  @override
  String get greetingMorning => 'Good morning!';

  @override
  String get greetingAfternoon => 'Good afternoon!';

  @override
  String get greetingEvening => 'Good evening!';

  @override
  String get greetingDefault => 'Hello!';

  @override
  String get welcomeSubtitle => 'Discover the best places in Cuba';

  @override
  String get defaultUserName => 'Explorer';

  @override
  String get categoryPopular => 'Popular';

  @override
  String get categoryFavorites => 'Favorites';

  @override
  String get categoryTrending => 'Trending';

  @override
  String get categoryEconomic => 'Budget';

  @override
  String get categoryTopRated => 'Top Rated';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryDrinks => 'Drinks';

  @override
  String get categoryOffers => 'Offers';

  @override
  String get categoryNearby => 'Nearby';

  @override
  String get categoryAll => 'All Categories';

  @override
  String get categoryRestaurants => 'Restaurants';

  @override
  String get categoryBars => 'Bars';

  @override
  String get categoryCafes => 'Cafes';

  @override
  String get categoryHotels => 'Hotels';

  @override
  String get categoryTours => 'Tours';

  @override
  String get categoryBeaches => 'Beaches';

  @override
  String get categoryNightlife => 'Nightlife';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryServices => 'Services';

  @override
  String get searchPlaceholder => 'Search places...';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchResults => 'Search results';

  @override
  String get searchNoResults => 'No results found';

  @override
  String get searchHint => 'What are you looking for?';

  @override
  String get searchRecent => 'Recent searches';

  @override
  String get searchSuggestions => 'Suggestions';

  @override
  String get reservationsTitle => 'Reservations';

  @override
  String get reservationsSystem => 'Reservation system available';

  @override
  String get reservationsViewAll => 'View all';

  @override
  String get reservationsNew => 'Make New Reservation';

  @override
  String get reservationsUpcoming => 'Upcoming Reservations';

  @override
  String reservationsPending(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pending reservations',
      one: '1 pending reservation',
    );
    return '$_temp0';
  }

  @override
  String get reservationsMyReservations => 'My Reservations';

  @override
  String get reservationsNoReservations => 'You have no reservations';

  @override
  String get reservationsNoUpcoming => 'No upcoming reservations';

  @override
  String get reservationsPast => 'Past Reservations';

  @override
  String get reservationsCancelled => 'Cancelled Reservations';

  @override
  String get reservationsConfirmed => 'Confirmed';

  @override
  String get reservationsPendingStatus => 'Pending';

  @override
  String get reservationsCancelledStatus => 'Cancelled';

  @override
  String get reservationsCompleted => 'Completed';

  @override
  String get reservationDetails => 'Reservation Details';

  @override
  String get reservationDate => 'Date';

  @override
  String get reservationTime => 'Time';

  @override
  String reservationGuests(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count guests',
      one: '1 guest',
    );
    return '$_temp0';
  }

  @override
  String get reservationSelectDate => 'Select Date';

  @override
  String get reservationSelectTime => 'Select Time';

  @override
  String get reservationSelectGuests => 'Number of Guests';

  @override
  String get reservationNotes => 'Additional notes';

  @override
  String get reservationNotesHint => 'Any special requests...';

  @override
  String get reservationConfirmTitle => 'Confirm Reservation';

  @override
  String get reservationConfirmMessage => 'Are you sure you want to make this reservation?';

  @override
  String get reservationCancelTitle => 'Cancel Reservation';

  @override
  String get reservationCancelMessage => 'Are you sure you want to cancel this reservation?';

  @override
  String get reservationSuccess => 'Reservation made successfully!';

  @override
  String get reservationCancelSuccess => 'Reservation cancelled';

  @override
  String get reservationError => 'Error processing reservation';

  @override
  String get reservationNoSlots => 'No available time slots';

  @override
  String get reservationSelectSlot => 'Select a time slot';

  @override
  String get reservationAvailableSlots => 'Available Slots';

  @override
  String get reservationContinue => 'Continue';

  @override
  String get reservationBack => 'Back';

  @override
  String get reservationSummary => 'Reservation Summary';

  @override
  String get promoSpecial => 'SPECIAL';

  @override
  String get promoTitle => 'Special offer!';

  @override
  String get promoDescription => 'Enjoy 20% off on tours in Havana';

  @override
  String get promoButton => 'View Offer';

  @override
  String get placeOpen => 'Open';

  @override
  String get placeClosed => 'Closed';

  @override
  String get placeOpenNow => 'Open now';

  @override
  String get placeClosedNow => 'Closed now';

  @override
  String get placeDetails => 'Details';

  @override
  String get placeDescription => 'Description';

  @override
  String get placeLocation => 'Location';

  @override
  String get placeContact => 'Contact';

  @override
  String get placeSchedule => 'Schedule';

  @override
  String get placeAmenities => 'Amenities';

  @override
  String get placePhotos => 'Photos';

  @override
  String get placeMoreInfo => 'More Info';

  @override
  String get placeSeeAll => 'See all';

  @override
  String get placeNoDescription => 'No description available';

  @override
  String get placeCallNow => 'Call';

  @override
  String get placeGetDirections => 'Get Directions';

  @override
  String get placeShare => 'Share';

  @override
  String get placeWebsite => 'Website';

  @override
  String get placeMenu => 'Menu';

  @override
  String get placeAveragePrice => 'Average price';

  @override
  String get placePriceRange => 'Price range';

  @override
  String placeFromPrice(String price) {
    return 'From \$$price';
  }

  @override
  String placeDistance(Object distance) {
    return '$distance km';
  }

  @override
  String get reviewsTitle => 'Reviews';

  @override
  String get reviewsAll => 'All reviews';

  @override
  String get reviewsWrite => 'Write Review';

  @override
  String get reviewsNoReviews => 'No reviews yet';

  @override
  String get reviewsBeFirst => 'Be the first to review';

  @override
  String reviewsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reviews',
      one: '1 review',
    );
    return '$_temp0';
  }

  @override
  String get reviewsRating => 'Rating';

  @override
  String get reviewsYourRating => 'Your rating';

  @override
  String get reviewsComment => 'Your comment';

  @override
  String get reviewsCommentHint => 'Tell us about your experience...';

  @override
  String get reviewsSubmit => 'Submit Review';

  @override
  String get reviewsSuccess => 'Review submitted!';

  @override
  String get reviewsError => 'Error submitting review';

  @override
  String get reviewsThankYou => 'Thank you for your feedback!';

  @override
  String get reviewsRatingRequired => 'Please select a rating';

  @override
  String get reviewsCommentRequired => 'Please write a comment';

  @override
  String get reviewsRecent => 'Most recent';

  @override
  String get reviewsBest => 'Best rated';

  @override
  String get offersTitle => 'Offers';

  @override
  String get offersSpecial => 'Special Offers';

  @override
  String get offersActive => 'Active Offers';

  @override
  String get offersExpired => 'Expired';

  @override
  String offersValidUntil(Object date) {
    return 'Valid until $date';
  }

  @override
  String offersDiscount(Object percent) {
    return '$percent% off';
  }

  @override
  String get offersNoOffers => 'No offers available';

  @override
  String get loadingPlaces => 'Loading places...';

  @override
  String get loadingData => 'Loading...';

  @override
  String get loadingMore => 'Loading more...';

  @override
  String get noPlacesAvailable => 'No places available';

  @override
  String get tryAnotherSearch => 'Try another search';

  @override
  String get errorOccurred => 'Something went wrong';

  @override
  String get errorGeneric => 'An error occurred';

  @override
  String get errorConnection => 'Connection error';

  @override
  String get errorTryAgain => 'Please try again';

  @override
  String get retry => 'Retry';

  @override
  String get refresh => 'Refresh';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsComingSoon => 'Notifications coming soon';

  @override
  String get notificationsEmpty => 'You have no notifications';

  @override
  String get notificationsMarkRead => 'Mark as read';

  @override
  String get notificationsClearAll => 'Clear all';

  @override
  String locationError(Object message) {
    return 'Location error: $message';
  }

  @override
  String get locationNotAvailable => 'Location not available. Showing all places.';

  @override
  String get requestingLocation => 'Requesting your location to show nearby places...';

  @override
  String get locationPermissionTitle => 'Location Permission';

  @override
  String get locationPermissionMessage => 'We need access to your location to show you nearby places';

  @override
  String get locationPermissionAllow => 'Allow';

  @override
  String get locationPermissionDeny => 'Deny';

  @override
  String get locationPermissionSettings => 'Go to Settings';

  @override
  String get locationDenied => 'Location permission denied';

  @override
  String get locationDisabled => 'Location services are disabled';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSelectTitle => 'Select Theme';

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeAppearance => 'Appearance';

  @override
  String get navExplore => 'Explore';

  @override
  String get navCategories => 'Categories';

  @override
  String get navEvents => 'Events';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'Profile';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navMap => 'Map';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEdit => 'Edit Profile';

  @override
  String get profileMyReservations => 'My Reservations';

  @override
  String get profileMyReservationsDesc => 'View and manage your reservations';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileNotificationsDesc => 'Configure alerts and notifications';

  @override
  String get profileHelp => 'Help & Support';

  @override
  String get profileHelpDesc => 'FAQ and contact';

  @override
  String get profileLogout => 'Log Out';

  @override
  String get profileLogoutConfirm => 'Are you sure you want to log out?';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profilePrivacy => 'Privacy';

  @override
  String get profileTerms => 'Terms & Conditions';

  @override
  String get profileAbout => 'About';

  @override
  String profileVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get profileFavorites => 'My Favorites';

  @override
  String get profileFavoritesDesc => 'Places you\'ve saved';

  @override
  String get profileAccount => 'My Account';

  @override
  String get profileAccountDesc => 'Personal information';

  @override
  String get profileWelcome => 'Welcome!';

  @override
  String get profileGuest => 'Guest';

  @override
  String get profileLoginPrompt => 'Log in to access all features';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get favoritesEmpty => 'You have no favorites';

  @override
  String get favoritesEmptyDesc => 'Places you save will appear here';

  @override
  String get favoritesRemove => 'Remove from favorites';

  @override
  String get favoritesAdd => 'Add to favorites';

  @override
  String get favoritesAdded => 'Added to favorites';

  @override
  String get favoritesRemoved => 'Removed from favorites';

  @override
  String get favoritesExplore => 'Explore places';

  @override
  String favoritesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count favorites',
      one: '1 favorite',
    );
    return '$_temp0';
  }

  @override
  String get eventsTitle => 'Events';

  @override
  String get eventsUpcoming => 'Upcoming Events';

  @override
  String get eventsToday => 'Today';

  @override
  String get eventsThisWeek => 'This Week';

  @override
  String get eventsThisMonth => 'This Month';

  @override
  String get eventsNoEvents => 'No events available';

  @override
  String get eventsNoUpcoming => 'No upcoming events';

  @override
  String get eventsDetails => 'Event Details';

  @override
  String get eventsDate => 'Event date';

  @override
  String get eventsTime => 'Time';

  @override
  String get eventsLocation => 'Location';

  @override
  String get eventsPrice => 'Price';

  @override
  String get eventsFree => 'Free';

  @override
  String get eventsInterested => 'Interested';

  @override
  String get eventsGoing => 'Going';

  @override
  String get eventsShare => 'Share event';

  @override
  String get eventsWelcomeTitle => 'Discover the best events!';

  @override
  String get eventsWelcomeSubtitle => 'Don\'t miss Cuba\'s most popular events';

  @override
  String get eventsWelcomeButton => 'View Events';

  @override
  String get eventsSeeAll => 'See all';

  @override
  String get authSignIn => 'Sign In';

  @override
  String get authSignUp => 'Sign Up';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authConfirmPassword => 'Confirm password';

  @override
  String get authForgotPassword => 'Forgot your password?';

  @override
  String get authWithGoogle => 'Continue with Google';

  @override
  String get authWithApple => 'Continue with Apple';

  @override
  String get authWithFacebook => 'Continue with Facebook';

  @override
  String get authOr => 'or';

  @override
  String get authNoAccount => 'Don\'t have an account?';

  @override
  String get authHaveAccount => 'Already have an account?';

  @override
  String get authCreateAccount => 'Create account';

  @override
  String get authWelcomeBack => 'Welcome back!';

  @override
  String get authWelcome => 'Welcome!';

  @override
  String get authLoginSubtitle => 'Sign in to continue';

  @override
  String get authSignUpSubtitle => 'Create your account to get started';

  @override
  String get authName => 'Full name';

  @override
  String get authPhone => 'Phone';

  @override
  String get authTermsAgree => 'By continuing, you agree to our';

  @override
  String get authTermsLink => 'Terms & Conditions';

  @override
  String get authPrivacyLink => 'Privacy Policy';

  @override
  String get authAnd => 'and';

  @override
  String get authInvalidEmail => 'Invalid email address';

  @override
  String get authInvalidPassword => 'Password must be at least 6 characters';

  @override
  String get authPasswordMismatch => 'Passwords don\'t match';

  @override
  String get authLoginSuccess => 'Logged in!';

  @override
  String get authLogoutSuccess => 'Logged out';

  @override
  String get authLoginError => 'Login error';

  @override
  String get authSignUpError => 'Sign up error';

  @override
  String get authResetPassword => 'Reset password';

  @override
  String get authResetPasswordSent => 'Password reset email sent';

  @override
  String get authContinueAsGuest => 'Continue as guest';

  @override
  String get bookingTitle => 'Book';

  @override
  String get bookingSelectDate => 'Select a date';

  @override
  String get bookingSelectTime => 'Select a time';

  @override
  String get bookingSelectGuests => 'Number of guests';

  @override
  String get bookingStep1 => 'Date & Time';

  @override
  String get bookingStep2 => 'Details';

  @override
  String get bookingStep3 => 'Confirmation';

  @override
  String get bookingConfirm => 'Confirm Booking';

  @override
  String get bookingModify => 'Modify';

  @override
  String get bookingCancel => 'Cancel Booking';

  @override
  String get bookingSpecialRequests => 'Special requests';

  @override
  String get bookingContactInfo => 'Contact information';

  @override
  String get bookingPayment => 'Payment method';

  @override
  String get bookingTotal => 'Total';

  @override
  String get bookingFree => 'Free';

  @override
  String get bookingDeposit => 'Deposit required';

  @override
  String get bookingPolicy => 'Cancellation policy';

  @override
  String get bookingPolicyText => 'Free cancellation up to 24 hours before';

  @override
  String get bookingFullName => 'Full name';

  @override
  String get bookingNameRequired => 'Name is required';

  @override
  String get bookingEmail => 'Email address';

  @override
  String get bookingEmailRequired => 'Email is required';

  @override
  String get bookingEmailInvalid => 'Invalid email';

  @override
  String get bookingPhone => 'Phone number';

  @override
  String get bookingPhoneRequired => 'Phone is required';

  @override
  String get bookingSpecialRequestsOptional => 'Special requests (optional)';

  @override
  String get bookingSpecialRequestsHint => 'E.g.: Table by the window, special celebration...';

  @override
  String get bookingPartySize => 'How many guests?';

  @override
  String get bookingPeopleCount => 'Number of people:';

  @override
  String get bookingCancellationPolicy => 'Cancellation policy';

  @override
  String get bookingCancellationPolicyText => 'You can cancel your reservation up to 2 hours before the scheduled time at no cost.';

  @override
  String get bookingConfirming => 'Confirming booking...';

  @override
  String get bookingLoginRequired => 'You must log in to make a reservation';

  @override
  String get mapTitle => 'Map';

  @override
  String get mapShowList => 'Show list';

  @override
  String get mapShowMap => 'Show map';

  @override
  String get mapMyLocation => 'My location';

  @override
  String get mapNearby => 'Nearby places';

  @override
  String get mapFilter => 'Filter';

  @override
  String get mapNoPlacesNearby => 'No places nearby';

  @override
  String get filterTitle => 'Filters';

  @override
  String get filterApply => 'Apply Filters';

  @override
  String get filterClear => 'Clear';

  @override
  String get filterReset => 'Reset';

  @override
  String get filterPrice => 'Price';

  @override
  String get filterRating => 'Rating';

  @override
  String get filterDistance => 'Distance';

  @override
  String get filterCategory => 'Category';

  @override
  String get filterOpenNow => 'Open now';

  @override
  String get filterSortBy => 'Sort by';

  @override
  String get filterRelevance => 'Relevance';

  @override
  String get filterNearest => 'Nearest';

  @override
  String get filterHighestRated => 'Highest rated';

  @override
  String get filterLowestPrice => 'Lowest price';

  @override
  String get filterHighestPrice => 'Highest price';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonClose => 'Close';

  @override
  String get commonAll => 'All';

  @override
  String get commonDone => 'Done';

  @override
  String get commonNext => 'Next';

  @override
  String get commonBack => 'Back';

  @override
  String get commonYes => 'Yes';

  @override
  String get commonNo => 'No';

  @override
  String get commonOk => 'OK';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonSeeMore => 'See more';

  @override
  String get commonSeeLess => 'See less';

  @override
  String get commonShare => 'Share';

  @override
  String get commonCopy => 'Copy';

  @override
  String get commonCopied => 'Copied';

  @override
  String get commonSend => 'Send';

  @override
  String get commonSubmit => 'Submit';

  @override
  String get commonApply => 'Apply';

  @override
  String get commonSelect => 'Select';

  @override
  String get commonSelected => 'Selected';

  @override
  String get commonRequired => 'Required';

  @override
  String get commonOptional => 'Optional';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonSuccess => 'Success!';

  @override
  String get commonError => 'Error';

  @override
  String get commonWarning => 'Warning';

  @override
  String get commonInfo => 'Information';

  @override
  String get commonToday => 'Today';

  @override
  String get commonTomorrow => 'Tomorrow';

  @override
  String get commonYesterday => 'Yesterday';

  @override
  String timeMinutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String timeHours(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String timeDays(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String timeAgo(Object time) {
    return '$time ago';
  }

  @override
  String get errorNetwork => 'No internet connection';

  @override
  String get errorServer => 'Server error';

  @override
  String get errorUnknown => 'Unknown error';

  @override
  String get errorTimeout => 'Request timeout';

  @override
  String get errorNotFound => 'Not found';

  @override
  String get errorUnauthorized => 'Unauthorized';

  @override
  String get errorForbidden => 'Access denied';

  @override
  String get successSaved => 'Saved successfully';

  @override
  String get successDeleted => 'Deleted successfully';

  @override
  String get successUpdated => 'Updated successfully';

  @override
  String get successSent => 'Sent successfully';

  @override
  String get dialogCloseConfirm => 'Are you sure you want to close?';

  @override
  String get dialogDeleteConfirm => 'Are you sure you want to delete?';

  @override
  String get dialogUnsavedChanges => 'You have unsaved changes';

  @override
  String get dialogDiscard => 'Discard';

  @override
  String get dialogKeepEditing => 'Keep editing';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingBack => 'Back';

  @override
  String get onboarding1Title => 'Discover Cuba';

  @override
  String get onboarding1Subtitle => 'Explore the best restaurants, bars, hotels and experiences that Cuba has to offer';

  @override
  String get onboarding2Title => 'Book Easily';

  @override
  String get onboarding2Subtitle => 'Make reservations in seconds. No calls, no waiting. Your table awaits with just one tap';

  @override
  String get onboarding3Title => 'Unique Events';

  @override
  String get onboarding3Subtitle => 'Don\'t miss the most exclusive events. Live music, gastronomy, art and Cuban culture';

  @override
  String get onboarding4Title => 'Save your Favorites';

  @override
  String get onboarding4Subtitle => 'Create your own collection of favorite places and access them whenever you want';

  @override
  String get onboardingWelcome => 'Welcome to';

  @override
  String get onboardingReadyToExplore => 'Ready to explore?';
}
