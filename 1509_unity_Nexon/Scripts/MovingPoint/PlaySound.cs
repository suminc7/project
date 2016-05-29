using UnityEngine;
using System.Collections;

public class PlaySound : MonoBehaviour {
	
	public Material defaultSky;
	public Light sun;
	public StanControl stan;
	public GameObject stanPositionObj;
	
	private Animator anim;

	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter(Collider other) {
		
		if (other.tag == "Player") {
			
			
			BGM bgm = GameObject.Find ("BGM").GetComponent<BGM> ();
			bgm.Play4 ();

			RenderSettings.skybox = defaultSky;
			anim = sun.GetComponent<Animator>();
			anim.SetBool("Dark", false);

			stan.MoveFinishPosition(stanPositionObj);
			
		}
		
	}
}
