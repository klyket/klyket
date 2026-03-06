import { XMLParser } from 'fast-xml-parser';
import type { SubstackPost, RSSItem } from './types';
import { stripHtml } from './utils';

const FEED_URL = 'https://klyket.substack.com/feed';

export async function fetchSubstackPosts(): Promise<SubstackPost[]> {
  try {
    const response = await fetch(FEED_URL);
    if (!response.ok) {
      console.warn(`RSS fetch failed with status ${response.status}`);
      return [];
    }

    const xml = await response.text();
    const parser = new XMLParser({
      ignoreAttributes: false,
      attributeNamePrefix: '@_',
    });

    const parsed = parser.parse(xml);
    const channel = parsed?.rss?.channel;

    if (!channel || !channel.item) {
      return [];
    }

    const items: RSSItem[] = Array.isArray(channel.item)
      ? channel.item
      : [channel.item];

    return items.map((item) => ({
      title: item.title || 'Untitled',
      link: item.link || '',
      pubDate: item.pubDate || '',
      description: stripHtml(item.description || ''),
      coverImage: extractCoverImage(item),
      author: item['dc:creator'] || 'Calum',
      guid: typeof item.guid === 'string' ? item.guid : item.guid?.['#text'] || item.link || '',
    }));
  } catch (error) {
    console.error('Error fetching RSS feed:', error);
    return [];
  }
}

function extractCoverImage(item: RSSItem): string | undefined {
  if (item.enclosure?.['@_url']) {
    return item.enclosure['@_url'];
  }
  const content = item['content:encoded'] || '';
  const match = content.match(/<img[^>]+src="([^"]+)"/);
  return match?.[1] || undefined;
}
