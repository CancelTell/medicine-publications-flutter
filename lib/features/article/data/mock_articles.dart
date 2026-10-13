import '../domain/article_model.dart';
import '../domain/article_type.dart';
final List<ArticleModel> mockArticles = [
  ArticleModel(
    pmid: 37952131,
    title: 'Semaglutide and Cardiovascular Outcomes in Obesity without Diabetes.',
    authors: ['Lincoff AM', 'Brown-Frandsen K', 'Colhoun HM', 'Deanfield J', 'Ryan DH'],
    description:
    'A trial of about 17,600 adults with overweight or obesity and existing '
        'cardiovascular disease, but no diabetes. Weekly semaglutide lowered the '
        'risk of major cardiovascular events compared with placebo.',
    type: ArticleType.randTrial,
    relatedIds: [33567185, 35658024, 27633186],
    publishedAt: DateTime(2023, 12, 14),
  ),
  ArticleModel(
    pmid: 35658024,
    title: 'Tirzepatide Once Weekly for the Treatment of Obesity.',
    authors: ['Jastreboff AM', 'Aronne LJ', 'Ahmad NN', 'Wharton S', 'Connery L'],
    description:
    'A phase 3 trial in adults with obesity. Weekly tirzepatide produced '
        'substantial, dose-dependent weight loss over 72 weeks compared with placebo.',
    type: ArticleType.randTrial,
    relatedIds: [33567185, 37952131],
    publishedAt: DateTime(2022, 7, 21),
  ),
  ArticleModel(
    pmid: 34265844,
    title: 'Highly accurate protein structure prediction with AlphaFold.',
    authors: ['Jumper J', 'Evans R', 'Pritzel A', 'Green T', 'Hassabis D'],
    description:
    'Presents AlphaFold, a neural network that predicts the 3D structure of a '
        'protein from its amino acid sequence, often with accuracy close to '
        'experimental methods.',
    type: ArticleType.research,
    relatedIds: [30617339],
    publishedAt: DateTime(2021, 8),
  ),
  ArticleModel(
    pmid: 33567185,
    title: 'Once-Weekly Semaglutide in Adults with Overweight or Obesity.',
    authors: ['Wilding JPH', 'Batterham RL', 'Calanna S', 'Davies M', 'Kushner RF'],
    description:
    'The STEP 1 trial: adults with overweight or obesity and no diabetes lost '
        'considerably more weight on weekly semaglutide than on placebo, alongside '
        'lifestyle intervention.',
    type: ArticleType.randTrial,
    relatedIds: [37952131, 35658024],
    publishedAt: DateTime(2021, 3, 18),
  ),
  ArticleModel(
    pmid: 32678530,
    title: 'Dexamethasone in Hospitalized Patients with Covid-19.',
    authors: ['RECOVERY Collaborative Group', 'Horby P', 'Lim WS', 'Landray MJ'],
    description:
    'A large randomized trial of hospitalized patients with Covid-19. '
        'Dexamethasone reduced deaths among patients who needed oxygen or '
        'ventilation, but not among those who did not.',
    type: ArticleType.randTrial,
    relatedIds: [31986264, 32015507],
    publishedAt: DateTime(2021, 2, 25),
  ),
  ArticleModel(
    pmid: 33378609,
    title: 'Efficacy and Safety of the mRNA-1273 SARS-CoV-2 Vaccine.',
    authors: ['Baden LR', 'El Sahly HM', 'Essink B', 'Kotloff K', 'Zaks T'],
    description:
    'A placebo-controlled phase 3 trial in about 30,000 adults. The mRNA-1273 '
        'vaccine was highly effective at preventing symptomatic Covid-19, with a '
        'mostly mild side-effect profile.',
    type: ArticleType.randTrial,
    relatedIds: [33301246, 32015507],
    publishedAt: DateTime(2021, 2, 4),
  ),
  ArticleModel(
    pmid: 33301246,
    title: 'Safety and Efficacy of the BNT162b2 mRNA Covid-19 Vaccine.',
    authors: ['Polack FP', 'Thomas SJ', 'Kitchin N', 'Absalon J', 'Gruber WC'],
    description:
    'A phase 3 trial of a two-dose mRNA vaccine in people aged 16 and older. '
        'The vaccine gave strong protection against Covid-19 in the weeks after the '
        'second dose.',
    type: ArticleType.randTrial,
    relatedIds: [33378609, 32015507],
    publishedAt: DateTime(2020, 12, 31),
  ),
  ArticleModel(
    pmid: 32015507,
    title: 'A pneumonia outbreak associated with a new coronavirus of probable bat origin.',
    authors: ['Zhou P', 'Yang XL', 'Wang XG', 'Hu B', 'Shi ZL'],
    description:
    'Reports the genome of the new coronavirus from patients in Wuhan, its '
        'close relation to a bat coronavirus, and its use of the ACE2 receptor to '
        'enter human cells.',
    type: ArticleType.research,
    relatedIds: [31986264, 33301246],
    publishedAt: DateTime(2020, 3),
  ),
  ArticleModel(
    pmid: 31986264,
    title: 'Clinical features of patients infected with 2019 novel coronavirus in Wuhan, China.',
    authors: ['Huang C', 'Wang Y', 'Li X', 'Ren L', 'Cao B'],
    description:
    'An early description of 41 hospitalized patients with confirmed infection: '
        'common symptoms, lung findings, and the share who needed intensive care.',
    type: ArticleType.research,
    relatedIds: [32015507, 32678530],
    publishedAt: DateTime(2020, 2, 15),
  ),
  ArticleModel(
    pmid: 31894144,
    title: 'International evaluation of an AI system for breast cancer screening.',
    authors: ['McKinney SM', 'Sieniek M', 'Godbole V', 'Godwin J', 'Shetty S'],
    description:
    'An AI system for reading mammograms was tested on data from the UK and the '
        'US. It matched or exceeded the accuracy of radiologists and reduced both '
        'false positives and false negatives.',
    type: ArticleType.research,
    relatedIds: [30617339, 28117445, 27898976],
    publishedAt: DateTime(2020, 1),
  ),
  ArticleModel(
    pmid: 31634902,
    title: 'Search-and-replace genome editing without double-strand breaks or donor DNA.',
    authors: ['Anzalone AV', 'Randolph PB', 'Davis JR', 'Sousa AA', 'Liu DR'],
    description:
    'Introduces prime editing, a method that writes new genetic information '
        'into a chosen DNA site without cutting both DNA strands and without a '
        'donor DNA template.',
    type: ArticleType.research,
    relatedIds: [27096365, 25430774],
    publishedAt: DateTime(2019, 12),
  ),
  ArticleModel(
    pmid: 30617339,
    title: 'High-performance medicine: the convergence of human and artificial intelligence.',
    authors: ['Topol EJ'],
    description:
    'A review of how deep learning is entering medicine, from image '
        'interpretation to clinical decision support, and of the limits and risks '
        'that come with it.',
    type: ArticleType.review,
    relatedIds: [31894144, 28117445, 27898976],
    publishedAt: DateTime(2019, 1),
  ),
  ArticleModel(
    pmid: 28117445,
    title: 'Dermatologist-level classification of skin cancer with deep neural networks.',
    authors: ['Esteva A', 'Kuprel B', 'Novoa RA', 'Ko J', 'Thrun S'],
    description:
    'A deep neural network trained on about 130,000 skin images classified '
        'skin lesions with accuracy comparable to board-certified dermatologists.',
    type: ArticleType.research,
    relatedIds: [30617339, 27898976],
    publishedAt: DateTime(2017, 2, 2),
  ),
  ArticleModel(
    pmid: 27898976,
    title:
    'Development and Validation of a Deep Learning Algorithm for Detection of '
        'Diabetic Retinopathy in Retinal Fundus Photographs.',
    authors: ['Gulshan V', 'Peng L', 'Coram M', 'Stumpe MC', 'Webster DR'],
    description:
    'A deep learning algorithm was trained to detect diabetic retinopathy in '
        'retinal photographs and validated on two separate image sets, showing high '
        'sensitivity and specificity.',
    type: ArticleType.validStudy,
    relatedIds: [30617339, 28117445],
    publishedAt: DateTime(2016, 12, 13),
  ),
  ArticleModel(
    pmid: 27633186,
    title: 'Semaglutide and Cardiovascular Outcomes in Patients with Type 2 Diabetes.',
    authors: ['Marso SP', 'Bain SC', 'Consoli A', 'Eliaschewitz FG', 'Vilsbøll T'],
    description:
    'The SUSTAIN-6 trial: in patients with type 2 diabetes at high '
        'cardiovascular risk, semaglutide lowered the rate of major cardiovascular '
        'events compared with placebo.',
    type: ArticleType.randTrial,
    relatedIds: [27295427, 37952131],
    publishedAt: DateTime(2016, 11, 10),
  ),
  ArticleModel(
    pmid: 27295427,
    title: 'Liraglutide and Cardiovascular Outcomes in Type 2 Diabetes.',
    authors: ['Marso SP', 'Daniels GH', 'Brown-Frandsen K', 'Mann JF', 'Buse JB'],
    description:
    'The LEADER trial: liraglutide reduced cardiovascular events and deaths in '
        'patients with type 2 diabetes at high cardiovascular risk, compared with '
        'placebo.',
    type: ArticleType.randTrial,
    relatedIds: [27633186],
    publishedAt: DateTime(2016, 7, 28),
  ),
  ArticleModel(
    pmid: 27096365,
    title:
    'Programmable editing of a target base in genomic DNA without '
        'double-stranded DNA cleavage.',
    authors: ['Komor AC', 'Kim YB', 'Packer MS', 'Zuris JA', 'Liu DR'],
    description:
    'Describes base editing, which converts one DNA letter into another at a '
        'chosen position without cutting both strands of the DNA.',
    type: ArticleType.research,
    relatedIds: [31634902, 25430774],
    publishedAt: DateTime(2016, 5, 19),
  ),
  ArticleModel(
    pmid: 25430774,
    title: 'Genome editing. The new frontier of genome engineering with CRISPR-Cas9.',
    authors: ['Doudna JA', 'Charpentier E'],
    description:
    'A review of how CRISPR-Cas9 works as a genome-editing tool, where it is '
        'already used in research, and the open questions about its wider use.',
    type: ArticleType.review,
    relatedIds: [22745249, 23287718],
    publishedAt: DateTime(2014, 11, 28),
  ),
  ArticleModel(
    pmid: 23287718,
    title: 'Multiplex genome engineering using CRISPR/Cas systems.',
    authors: ['Cong L', 'Ran FA', 'Cox D', 'Lin S', 'Zhang F'],
    description:
    'Shows that CRISPR/Cas systems can be engineered to edit genes in human '
        'and mouse cells, including several different sites at the same time.',
    type: ArticleType.research,
    relatedIds: [22745249, 25430774],
    publishedAt: DateTime(2013, 2, 15),
  ),
  ArticleModel(
    pmid: 22745249,
    title:
    'A programmable dual-RNA-guided DNA endonuclease in adaptive bacterial '
        'immunity.',
    authors: ['Jinek M', 'Chylinski K', 'Fonfara I', 'Doudna JA', 'Charpentier E'],
    description:
    'Shows that the Cas9 protein can be directed by a guide RNA to cut DNA at '
        'a chosen site, the basis of the CRISPR-Cas9 genome-editing technique.',
    type: ArticleType.research,
    relatedIds: [23287718, 25430774],
    publishedAt: DateTime(2012, 8, 17),
  ),
];