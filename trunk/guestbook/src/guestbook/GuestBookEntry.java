package guestbook;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Id;

public class GuestBookEntry {

	@Id
	private Long id;

    private String content;
    
    private Set<String> fts = new HashSet<String>();
    
    public Long getId() {
        return id;
    }

    public String getContent() {
        return content;
    }

    public void contentForSearch(String content) {
        this.content = content;
        SearchJanitor.updateFTSStuffForGuestBookEntry(this);
    }

	public void setFts(Set<String> fts) {
		this.fts = fts;
	}

	public Set<String> getFts() {
		return fts;
	}
}
