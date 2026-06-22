import '../models/question_model.dart';

List<Question> quizQuestions = [
  Question(
    id: '1',
    title: 'What is the main purpose of a Sales ERP system?',
    options: {
      'Manage employee attendance': false,
      'Track and manage sales processes': true,
      'Design company logo': false,
      'Create social media posts': false,
    },
  ),
  Question(
    id: '2',
    title: 'Which document is generated after confirming a sales order?',
    options: {
      'Purchase Invoice': false,
      'Delivery Challan': true,
      'Salary Slip': false,
      'Expense Voucher': false,
    },
  ),
  Question(
    id: '3',
    title: 'What does CRM stand for in Sales ERP?',
    options: {
      'Customer Revenue Model': false,
      'Customer Relationship Management': true,
      'Central Report Manager': false,
      'Company Resource Method': false,
    },
  ),
  Question(
    id: '4',
    title: 'Which module helps track customer payments?',
    options: {
      'Inventory Module': false,
      'HR Module': false,
      'Accounts Receivable': true,
      'Production Module': false,
    },
  ),
  Question(
    id: '5',
    title: 'What is the benefit of real-time sales reporting in ERP?',
    options: {
      'Faster decision making': true,
      'Increase office rent': false,
      'Reduce internet speed': false,
      'Remove customers': false,
    },
  ),
];
