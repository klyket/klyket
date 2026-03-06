export interface SubstackPost {
  title: string;
  link: string;
  pubDate: string;
  description: string;
  coverImage?: string;
  author: string;
  guid: string;
}

export interface RSSItem {
  title: string;
  link: string;
  description: string;
  'content:encoded'?: string;
  enclosure?: {
    '@_url': string;
    '@_type': string;
    '@_length': string;
  };
  pubDate: string;
  guid: string | { '#text': string };
  'dc:creator'?: string;
}
