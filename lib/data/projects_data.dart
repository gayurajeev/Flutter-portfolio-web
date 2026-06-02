import '../models/project.dart';

const List<Project> projects = [
  Project(
    number: '01',
    category: 'PYTHON',
    title: 'IBM HR — Employee Attrition',
    subtitle: 'Why people leave, and who to keep.',
    description:
        'Diagnosed 16.12% attrition across 1,470 employees at IBM. Surfaced the departments, roles and life-stages driving turnover so HR can act before the resignation letter lands.',
    bullets: [
      'Identified R&D as the top attrition source — 961 of 1,470 exits.',
      'Mapped attrition against job satisfaction, overtime and monthly income.',
      'Built an interactive Tableau dashboard with role × satisfaction heatmap.',
    ],
    tags: ['PANDAS', 'NUMPY', 'SEABORN', 'TABLEAU PUBLIC'],
    imagePath: 'assests/project1.png',
    imageLeft: false,
  ),
  Project(
    number: '02',
    category: 'PYTHON',
    title: 'US Accidents — Exploratory Analysis',
    subtitle: '7M+ records, one honest narrative.',
    description:
        'Wrangled the US Accidents dataset (7M+ rows, 2016–2023) end-to-end — cleaned timestamps, weather and severity fields, then surfaced when, where and under what conditions accidents actually happen.',
    bullets: [
      'Severity skews toward weekday rush hours, not late-night driving.',
      'Top hotspots concentrate around California, Florida and Texas corridors.',
      'Built reusable EDA notebook with weather × severity correlation plots.',
    ],
    tags: ['PANDAS', 'NUMPY', 'MATPLOTLIB', 'SEABORN', 'GEO PLOTTING'],
    imagePath: 'assests/project2.jpg',
    imageLeft: true,
  ),
  Project(
    number: '03',
    category: 'PYTHON',
    title: 'Fitness Activity Analysis',
    subtitle: 'Turning wearable noise into behavior.',
    description:
        'Cleaned a month of fitness-tracker logs and reframed steps, distance and calories around weekday rhythm — exposing sedentary patterns vs. peak active days.',
    bullets: [
      'Peak day: 220K+ steps and 390 km of total distance.',
      'Tuesday flagged as the highest calorie-burn weekday.',
      'Sedentary minutes 8× larger than active — clear intervention point.',
    ],
    tags: ['PANDAS', 'MATPLOTLIB', 'SEABORN', 'TABLEAU'],
    imagePath: 'assests/project3.png',
    imageLeft: false,
  ),
  Project(
    number: '04',
    category: 'EXCEL',
    title: 'Coffee Sales Dashboard',
    subtitle: 'From raw orders to regional decisions.',
    description:
        'An end-to-end Excel model: cleaned the order book, joined customer + region data with XLOOKUP, and shipped an interactive dashboard with slicers for roast, size and loyalty.',
    bullets: [
      'United States: \$3,347 — leading market vs. Ireland & UK.',
      'Top-5 customers contribute the long tail of revenue.',
      'Slicers for Roast Type, Loyalty and Size for self-serve analysis.',
    ],
    tags: ['EXCEL', 'XLOOKUP', 'PIVOTTABLES', 'PIVOTCHARTS'],
    imagePath: 'assests/project4.png',
    imageLeft: true,
  ),
  Project(
    number: '05',
    category: 'PRODUCT',
    title: "SheSafe — Women's Safety App",
    subtitle: 'Dignity and safety, mapped to a kilometer.',
    description:
        'Co-designed a women-first mobile experience that finds nearby washrooms within 1 km and triggers an SOS to emergency contacts — built around accessibility and trust scores.',
    bullets: [
      'Trust scoring per location (Safe / Moderate / High-risk).',
      'Category filters: hotels, malls, hospitals, petrol pumps, beaches.',
      'One-tap SOS to pre-saved emergency contacts.',
    ],
    tags: ['PRODUCT THINKING', 'GEO DATA', 'UX RESEARCH', 'FLUTTER'],
    imagePath: 'assests/project5.png',
    imageLeft: false,
  ),
];
