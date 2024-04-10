import httpStatus from "http-status";
import prisma from "../../client";
import ApiError from "../../utils/ApiError";
import { articleKeys } from "../constants/fields";
import {
  NewsNotification,
  NotificationCategory,
} from "../models/app_notification";
import { Article } from "../models/article";
import notificationService from "./notification.service";

const notifyUsers = async (article: any) => {
  const categories = article.categories;

  if (!Array.isArray(categories)) {
    return;
  }

  for (const category of categories) {
    const newsNotification: NewsNotification = {
      topic: category.name,
      payload: {
        article: article,
        category: NotificationCategory.deliverNews,
      },
    };

    console.log(JSON.stringify(newsNotification.payload));

    // notificationService.notifyTopic(newsNotification);
  }
};

const createArticle = async (article: Article) => {
  const response = await prisma.article.create({
    data: {
      title: article.title,
      content: article.content,
      image: article.image,
      published_on: article.published_on,
      source_url: article.source_url,
      category_ids: article.categories as string[],
      user_id: article.user_id,
    },
    select: {
      ...articleKeys.reduce((obj, k) => ({ ...obj, [k]: true }), {}),
    },
  });

  // notify others
  // notifyUsers(response);

  return response;
};

const queryArticles = () => {
  return prisma.article.findMany({
    select: {
      id: true,
      title: true,
      content: true,
      categories: true,
      author: true,
    },
  });
};

const createArticles = async () => {
  const businessArticles = [
    {
      source: {
        id: null,
        name: "MINING.com",
      },
      author: null,
      title:
        "Copper price near 15-month high as supply fears spur bullish calls - MINING.COM - MINING.com",
      description:
        "Citigroup said there’s potential for “explosive price upside” again in the next three years.",
      url: "https://www.mining.com/web/copper-is-entering-a-new-bull-market-phase-citi-says/",
      urlToImage:
        "https://www.mining.com/wp-content/uploads/2024/04/AdobeStock_636250452-1024x683.jpeg",
      publishedAt: "2024-04-09T15:33:45Z",
      content:
        "Used in power cables, wind turbines, electric vehicles and solar panels, copper is a key material for the energy transition.\r\nCoppers second secular bull market this century is being driven by boomin… [+1148 chars]",
    },
    {
      source: {
        id: null,
        name: "Hindustan Times",
      },
      author: "Arfa Javaid",
      title:
        "Nita Ambani buys Rolls-Royce Phantom VIII worth over ₹12 crore with custom NMA embroidery on headrests. See pics - Hindustan Times",
      description:
        "The Rolls-Royce Phantom VIII that Nita Ambani bought has a velvet orchid upper body, rose quartz lower body, gold SoE, dinner plate wheels and NMA initials.  | Trending",
      url: "https://www.hindustantimes.com/trending/nita-ambani-buys-rolls-royce-phantom-viii-worth-rs-12-crore-with-custom-nma-embroidery-on-headrests-see-pics-101712669838701.html",
      urlToImage:
        "https://www.hindustantimes.com/ht-img/img/2024/04/09/1600x900/nita-ambani-rolls-royce-luxurious-car-viral_1712670124414_1712670135632.jpg",
      publishedAt: "2024-04-09T13:51:04Z",
      content:
        "Nita Ambani, chairman and founder of the Reliance Foundation, recently bought a personalised Rolls-Royce Phantom VIII worth over 12 crore. The luxurious car has a velvet orchid upper body, rose quart… [+1949 chars]",
    },
    {
      source: {
        id: null,
        name: "FXStreet",
      },
      author: "Sagar Dua",
      title:
        "Gold hits new highs near $2,360 on firm safe-haven demand, US Inflation eyed - FXStreet",
      description:
        "Gold price (XAU/USD) keeps moving higher due to fresh escalation in Israel-Hamas tensions in the Middle East region.",
      url: "https://www.fxstreet.com/news/gold-price-keeps-rising-on-escalating-geopolitical-tensions-as-us-inflation-comes-into-focus-202404091047",
      urlToImage:
        "https://editorial.fxstreet.com/images/Markets/Commodities/Metals/Gold/gold-on-weight-scale-gm165418687-21879510_Large.jpg",
      publishedAt: "2024-04-09T13:45:31Z",
      content:
        "<ul><li>Gold price jumps above $2,360 on fresh escalation in Israel-Hamas tensions.</li><li> Fed’s Goolsbee warns of upside risks to unemployment if interest rates remain higher for longer.</li><li> … [+6195 chars]",
    },
    {
      source: {
        id: "the-times-of-india",
        name: "The Times of India",
      },
      author: "TIMESOFINDIA.COM",
      title:
        "Maruti Suzuki adds new assembly line at Manesar plant: Increases production capacity to 9 lakh units per - The Times of India",
      description:
        "Cars News: The Manesar facility has contributed over 95 lakh units in Maruti Suzuki’s Crore production milestone. Several best-selling vehicles like Brezza, Erti",
      url: "https://timesofindia.indiatimes.com/auto/cars/maruti-suzuki-adds-new-assembly-line-at-manesar-plant-increases-production-capacity-to-9-lakh-units-per-annum/articleshow/109165837.cms",
      urlToImage:
        "https://static.toiimg.com/thumb/msid-109165808,width-1070,height-580,imgsize-1875677,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg",
      publishedAt: "2024-04-09T12:37:00Z",
      content:
        "Ather Rizta family e-scooter in images: Range, price, deliveries and more",
    },
    {
      source: {
        id: null,
        name: "News18",
      },
      author: "Shahrukh Shah",
      title:
        "2024 Bajaj Pulsar 150 Reaches Dealerships Ahead of Official Launch, What's New? - News18",
      description:
        "The company silently has made some changes to the Pulsar 150cc, making it fully compliant with the latest emission norms in India.",
      url: "https://www.news18.com/auto/2024-bajaj-pulsar-150-reaches-dealerships-ahead-of-official-launch-whats-new-8845756.html",
      urlToImage:
        "https://images.news18.com/ibnlive/uploads/2024/04/new-project-1-4-50-2024-04-bc54cd07255f2aaf11a25e232aa2e1df-16x9.jpg?impolicy=website&width=1200&height=675",
      publishedAt: "2024-04-09T12:35:16Z",
      content:
        "The Pulsar range is one of the all-time favorite series from the  Bajaj till date. The motorcycles under this series have ruled the market over the years. Now the company is gearing up to get an upda… [+1723 chars]",
    },
    {
      source: {
        id: "the-times-of-india",
        name: "The Times of India",
      },
      author: "Kshitij Anand",
      title:
        "Technical Breakout Stocks: How to trade Tata Power, Hindustan Zinc and Sobha on Wednesday? - The Economic Times",
      description:
        "The Indian markets pared gains after hitting fresh record highs on Tuesday. The S&P BSE Sensex climbed Mount 75K for the first time to hit a record high of 75,124 while the Nifty50 hit a record high of 22,768.",
      url: "https://economictimes.indiatimes.com/markets/stocks/news/technical-breakout-stocks-how-to-trade-tata-power-hindustan-zinc-and-sobha-on-wednesday/articleshow/109166945.cms",
      urlToImage:
        "https://img.etimg.com/thumb/msid-109167021,width-1200,height-630,imgsize-24788,overlay-etmarkets/photo.jpg",
      publishedAt: "2024-04-09T12:27:46Z",
      content:
        "The Indian markets pared gains after hitting fresh record highs on Tuesday.The S&amp;P BSE Sensex climbed Mount 75K for the first time to hit a record high of 75,124 while the Nifty50 hit a record hi… [+1885 chars]",
    },
    {
      source: {
        id: null,
        name: "NDTV News",
      },
      author: null,
      title:
        "Ola To Shut Down In UK, Australia, New Zealand, Focus On India Business - NDTV",
      description:
        "Ride-hailing services provider Ola has decided to shut down operations in the UK, Australia and New Zealand and will continue to focus on India business, its promoter ANI Technologies said today.",
      url: "https://www.ndtv.com/india-news/ola-to-shut-down-in-uk-australia-new-zealand-focus-on-india-business-5406409",
      urlToImage:
        "https://c.ndtvimg.com/2020-03/gg4ocjf8_ola-cabs_650x400_26_March_20.jpg",
      publishedAt: "2024-04-09T12:02:58Z",
      content:
        "Ride-hailing cab service Ola has decided to shut down operations in the UK, Australia and New Zealand\r\nNew Delhi: Ride-hailing services provider Ola has decided to shut down operations in the UK, Aus… [+1733 chars]",
    },
    {
      source: {
        id: null,
        name: "Hindustan Times",
      },
      author: "HT News Desk",
      title:
        "Paytm Payments Bank MD, CEO Surinder Chawla resigns - Hindustan Times",
      description:
        "The exit follows the stepping down of Paytm's top boss Vijay Shekhar Sharma as non-executive chairman of Paytm Payments Bank.",
      url: "https://www.hindustantimes.com/business/paytm-payments-bank-md-ceo-surinder-chawla-resigns-101712663690204.html",
      urlToImage:
        "https://www.hindustantimes.com/ht-img/img/2024/04/09/1600x900/Paytm-Payments-Bank_Surinder-Chawla-as-MD-CEO_1712664082968_1712664091235.jpg",
      publishedAt: "2024-04-09T12:00:36Z",
      content:
        'Beleagueredfintech companyPaytm on Tuesday announced that Surinder Chawla has resigned as the chief executive officer of its banking unit Paytm Payments Bank "on account of personal reasons". The com… [+2086 chars]',
    },
    {
      source: {
        id: null,
        name: "Bar & Bench - Indian Legal News",
      },
      author: "Neha Joshi",
      title:
        "NCLT grants 60-day extension to Go First Airlines for insolvency resolution - Bar & Bench - Indian Legal News",
      description:
        "The National Company Law Tribunal (NCLT) at Delhi on April 8 granted another 60-day extension to Shailendra Ajmera, resolution professional (RP) of Go First Air",
      url: "https://www.barandbench.com/news/nclt-grants-60-day-extension-to-go-first-airlines-for-insolvency-resolution",
      urlToImage:
        "https://media.assettype.com/barandbench%2F2023-05%2Ffa482e3f-6722-4441-96c2-f44c1331213c%2F14.jpg?rect=0%2C60%2C1600%2C840&w=1200&ar=40%3A21&auto=format%2Ccompress&ogImage=true&mode=crop&enlarge=true&overlay=false&overlay_position=bottom&overlay_width=100",
      publishedAt: "2024-04-09T11:43:33Z",
      content:
        "As per the Insolvency and Backruptcy Code, a company declared insolvent gets 180 days to complete the insolvency process before the liquidation process can begin.\r\nNCLT can grant an extension of 90 d… [+232 chars]",
    },
    {
      source: {
        id: null,
        name: "Livemint",
      },
      author: "Dhanya Nagasundaram",
      title:
        "Bharti Hexacom IPO to debut on the bourses on April 12; here's what GMP, subscription status hint ahead of listing | Mint - Mint",
      description:
        "Bharti Hexacom IPO listing date set for April 12, shares to be credited to demat accounts on April 10.  Bharti Hexacom IPO subscription status strong with QIBs leading, retail investors demand decent. Expected listing price around 10-12% higher than issue pri…",
      url: "https://www.livemint.com/market/ipo/bharti-hexacom-ipo-to-debut-on-the-bourses-on-april-12-heres-what-gmp-subscription-status-hint-ahead-of-listing-11712654793786.html",
      urlToImage:
        "https://www.livemint.com/lm-img/img/2024/04/09/1600x900/company-profile-banner-new-06052022_1712316629773_1712657799156.jpg",
      publishedAt: "2024-04-09T10:14:07Z",
      content:
        "Bharti Hexacom IPO listing date has been scheduled for Friday, April 12. This week is a truncated week as the domestic benchmark indices will remain closed on Thursday, April 11, on account of Ramada… [+5184 chars]",
    },
    {
      source: {
        id: null,
        name: "Livemint",
      },
      author: "Nikita Prasad",
      title:
        "Exide Industries hits back-to-back 52-week high on EV deal with Hyundai, Kia; Time to buy? | Mint - Mint",
      description:
        "Exide Industries share price hit a fresh 52-week high at  ₹398.05 apiece on the BSE after South Korean auto giants Hyundai Motor Company and Kia Corporation announced a partnership with Exide Energy Solutions Ltd",
      url: "https://www.livemint.com/market/stock-market-news/exide-industries-hits-back-to-back-52-week-high-on-hyundai-kia-deal-should-you-buy-sell-or-hold-11712656336826.html",
      urlToImage:
        "https://www.livemint.com/lm-img/img/2024/04/09/1600x900/LiveMint_1712656345414_1712656345534.jpg",
      publishedAt: "2024-04-09T09:58:13Z",
      content:
        "Shares of Exide Industries hit back-to-back 52-week high after the batter maker signed a deal with Hyundai Motors Company and Kia Corporation for the production of electric vehicles (EV) batteries in… [+3046 chars]",
    },
    {
      source: {
        id: null,
        name: "CNBCTV18",
      },
      author: "Madeeha Mujawar",
      title:
        "Former SpiceJet chief Arun Kashyap launches private charter carrier Sirius India Airlines - CNBCTV18",
      description:
        "Sirius India Airlines has set its sights on expansion, starting operations with a single Hawker 4000 jet. However, the ambitious venture aims to swiftly expand its fleet, with projections to grow to three jets in the upcoming months.",
      url: "https://www.cnbctv18.com/aviation/former-spicejet-chief-arun-kashyap-launches-private-charter-carrier-sirius-india-airlines-19394320.htm",
      urlToImage:
        "https://images.cnbctv18.com/uploads/2024/04/arun-kashyap-2024-04-169f2a866d007cf3e5cafb71ff7d51b3.jpeg?im=FitAndFill,width=500,height=300",
      publishedAt: "2024-04-09T09:57:11Z",
      content:
        "Former SpiceJet executive Arun Kashyap has launched Sirius India Airlines, a private charter carrier aimed at catering to the upscale travel market.Kashyap, who served as the Chief Operating Officer … [+1618 chars]",
    },
    {
      source: {
        id: null,
        name: "CNBCTV18",
      },
      author: "Daanish Anand",
      title:
        "Domestic airfare surge: You may now have to pay up to 30% more on these key routes - CNBCTV18",
      description:
        "As per two travel portals, Yatra Online & ixigo, spot airfare on certain routes have increased between 8-30%. As per Yatra Online, ticket prices have increased by 20-25% across key routes.",
      url: "https://www.cnbctv18.com/aviation/domestic-airfare-surge-travellers-face-up-to-30-percent-price-increase-on-key-routes-amid-vistara-crisis-19394272.htm",
      urlToImage:
        "https://images.cnbctv18.com/uploads/2023/05/airfares.jpg?im=FitAndFill,width=500,height=300",
      publishedAt: "2024-04-09T09:28:43Z",
      content:
        "The next time you book your domestic flight tickets be ready to pay extra as ticket prices on several key routes have spiked. While the Indian aviation industry had already factored in the rise in ti… [+3332 chars]",
    },
    {
      source: {
        id: null,
        name: "News18",
      },
      author: "Mohammad Haris",
      title:
        "Gold Price Increases In India: Check 24 Carat Rate In Your City On April 9 - News18",
      description:
        "Check gold rates today in different cities on April 9, 2024; (In Rs/10 grams)",
      url: "https://www.news18.com/business/gold-price-increases-in-india-check-24-carat-rate-in-your-city-on-april-9-8845156.html",
      urlToImage:
        "https://images.news18.com/ibnlive/uploads/2023/10/untitled-design-8-2023-10-2570de316084e89c2406b18d471deb3f-16x9.jpg?impolicy=website&width=1200&height=675",
      publishedAt: "2024-04-09T09:11:35Z",
      content:
        "Gold Rate Today In India: On April 9, 2024, gold prices experienced an increase in India largely. However, the fundamental price for 10 grams remained close to Rs 65,750. A thorough analysis of the m… [+2223 chars]",
    },
    {
      source: {
        id: null,
        name: "Ndtvprofit.com",
      },
      author: "Anjali Rai",
      title:
        "MSCI India Index Rejig: These 18 Stocks May See $2.7 Billion Inflows, Says JM Financial - NDTV Profit",
      description:
        "The rejig may attract about $2.7 billion inflows as Canara Bank, Voltas, Oil India, Nykaa, Policybazaar are likely to be among the 18 stocks to be included in the index. JM Financial said.",
      url: "https://www.ndtvprofit.com/business/msci-india-index-rejig-these-stocks-may-see-27-billion-inflows-says-jm-financial",
      urlToImage:
        "https://media.assettype.com/bloombergquint%2F2024-04%2Fec7fbb6a-4cf4-42fa-98a1-5c8d9450336f%2Fgolden_bull_and_bear_on_stock_data_chart_backgroun_2023_11_27_05_34_36_utc.jpg?rect=0%2C127%2C7200%2C3780&w=320&h=180&auto=format%2Ccompress&ogImage=true",
      publishedAt: "2024-04-09T08:53:59Z",
      content:
        "Sundaram Finance Ltd., PB Fintech Ltd.the operator of Policybazaar, Dixon Technologies Ltd., and The Phoenix Mills Ltd. might be among the 18 stocks to be included, according to JM Financials.\r\nNykaa… [+360 chars]",
    },
    {
      source: {
        id: null,
        name: "CNBCTV18",
      },
      author: "Ashmit Kumar",
      title:
        "Jindal Poly Films faces class action suit alleging fund mismanagement and ₹2,000 crore losses - CNBCTV18",
      description:
        "In the suit, the complainants alleged siphoning off of funds to promoters, resulting in a staggering loss of approximately ₹2,000 crore to the company.",
      url: "https://www.cnbctv18.com/business/companies/jindal-poly-films-faces-class-action-suit-alleging-fund-mismanagement-and-losses-19394250.htm",
      urlToImage:
        "https://images.cnbctv18.com/uploads/2024/01/budget-terms-2.jpg?im=FitAndFill,width=500,height=300",
      publishedAt: "2024-04-09T08:21:36Z",
      content:
        "Minority shareholders of Jindal Poly Films have filed a class action suit with the National Company Law Tribunal (NCLT) alleging the siphoning off of funds to promoters, resulting in a staggering los… [+1686 chars]",
    },
    {
      source: {
        id: null,
        name: "Bar & Bench - Indian Legal News",
      },
      author: "Satyendra Wankhade",
      title:
        "NCDRC directs Mahindra to replace defective XUV500 or issue full refund of ₹13 lakh - Bar & Bench - Indian Legal News",
      description:
        "The National Consumer Disputes Redressal Commission (NCDRC) recently upheld an order of a State Commission directing Mahindra &amp; Mahindra to either replace a",
      url: "https://www.barandbench.com/news/ncdrc-directs-mahindra-replace-defective-xuv500-or-issue-full-refund-13-lakh",
      urlToImage:
        "https://media.assettype.com/barandbench%2F2024-04%2F41484b69-4fcd-46c0-a47f-5554a79740b2%2F16.jpg?w=1200&ar=40%3A21&auto=format%2Ccompress&ogImage=true&mode=crop&enlarge=true&overlay=false&overlay_position=bottom&overlay_width=100",
      publishedAt: "2024-04-09T08:15:59Z",
      content:
        "According to the complainant, issues with ignition, braking, lights, and auto central lock began to surface shortly after he purchased the car. Despite numerous attempts at repair, these problems per… [+884 chars]",
    },
  ];

  for (const article of businessArticles) {
    const myArticle: Article = {
      title: article.title,
      content: article.description,
      image: article.urlToImage,
      published_on: new Date(article.publishedAt),
      categories: ["6616ae11754e1ade06474027"],
      source_url: article.url,
      user_id: "66123bbb626b1f2ec0ae9d38",
    };

    await createArticle(myArticle);
  }

  return "Done";
};

const testing = async () => {
  createArticles();
  return "Done";
};

export default {
  createArticle,
  queryArticles,
  testing,
};
